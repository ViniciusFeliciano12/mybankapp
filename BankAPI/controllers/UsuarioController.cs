using BankAPI.Models;
using BankAPI.Data;
using Microsoft.AspNetCore.Mvc;
using BankAPI.DTO;
using Microsoft.IdentityModel.Tokens;
using Microsoft.EntityFrameworkCore;
using MyBank.DTO;

namespace Events.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsuarioController : ControllerBase
    {
        [HttpGet]
        [Route("/usuarios")]
        public IActionResult Get(
            [FromServices] AppDbContext context)
        {
            return Ok(context.Usuarios!.ToList());
        }

        [HttpGet]
        [Route("/usuarios/{id:int}")]
        public IActionResult Get(
            [FromRoute] int id,
            [FromServices] AppDbContext context)
        {
            var usuarioModel = context.Usuarios!.FirstOrDefault(x => x.ID == id);
            if (usuarioModel == null){
                return NotFound();
            }
            return Ok(usuarioModel);
        }

        [HttpPost("/gerarUsuarioAsync")]
        public IActionResult GerarUsuario([FromBody] GerarUsuarioDTO gerarUsuarioDTO,
        [FromServices] AppDbContext context){
            var model = context.Usuarios!.ToList();
            UsuarioModel usuario = new UsuarioModel
            {
                ID = model.Count == 0 ? 0 : model.Last().ID+1,
                Nome = gerarUsuarioDTO.Nome,
                Sobrenome = gerarUsuarioDTO.Sobrenome,
                Dinheiro = 0,
                Cartao = null,
            };
            bool pixKeyUtilized = false;
            foreach(var items in model){
                if (items.ChavePIX == gerarUsuarioDTO.ChavePIX){
                    pixKeyUtilized = true;
                }
            }
            if (pixKeyUtilized || string.IsNullOrEmpty(gerarUsuarioDTO.ChavePIX)){
                usuario.ChavePIX = usuario.GerarChavePix(10);
            }
            else{
                usuario.ChavePIX = gerarUsuarioDTO.ChavePIX;
            }
            ContaModel? contaReal;
            try{
                contaReal = context.Contas!
                .Where(a => a.ID == gerarUsuarioDTO.ID && a.NomeUsuario == gerarUsuarioDTO.NomeUsuario && a.Senha == gerarUsuarioDTO.Senha)
                .Include(a => a.Usuario)
                .First();
            }catch{
                return NotFound(gerarUsuarioDTO);
            }
            
            
            if(contaReal == null){
                return NotFound(gerarUsuarioDTO);
            }

            if (contaReal.Usuario != null){
                return Conflict("Conta já possui usuário");
            }

            contaReal.Usuario = usuario;

            context.Contas!.Update(contaReal);
            context.SaveChanges();
            return Created($"/{contaReal}", contaReal);
        }

        [HttpPut("/editUserAsync")]
        public IActionResult EditUserAsync( 
        [FromBody] EditUserDTO usuarioModel,
        [FromServices] AppDbContext context){
            var model = context.Usuarios!.FirstOrDefault(x => x.ID == usuarioModel.IdUser);
            var account = context.Contas!.Include(a => a.Usuario).FirstOrDefault(x => x.ID == usuarioModel.IdAccount);

            if (model == null || account == null){
                return NotFound();
            }
            if (account.Usuario!.ID != usuarioModel.IdUser){
                return Conflict("ID do usuário enviado não confere com o ID de usuário associado ao ID da conta.");
            }

            if (account.Senha != usuarioModel.Password){
                return Conflict("Senha informada não confere com a senha da conta.");
            }

            model.Nome = usuarioModel.Name;
            model.Sobrenome = usuarioModel.Sobrenome;

            account.Usuario.Sobrenome = usuarioModel.Sobrenome;
            account.Usuario.Nome = usuarioModel.Name;

            context.Usuarios!.Update(model);
            context.SaveChanges();
            return Ok(account);
        }

        [HttpDelete("/usuarios/{id:int}")] 
        public IActionResult Delete([FromRoute] int id,
        [FromServices] AppDbContext context){
            var model = context.Usuarios!.FirstOrDefault(x => x.ID == id);
            if (model == null){
                return NotFound();
            }

            context.Usuarios!.Remove(model);
            context.SaveChanges();
            return Ok(model);
        }
    }
}