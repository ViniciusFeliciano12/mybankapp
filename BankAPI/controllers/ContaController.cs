using BankAPI.Models;
using BankAPI.Data;
using Microsoft.AspNetCore.Mvc;
using BankAPI.DTO;
using Microsoft.AspNetCore.Cors;
using MyBank.DTO;
using Microsoft.EntityFrameworkCore;

namespace Events.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ContaController : ControllerBase
    {
        [HttpGet]
        [EnableCors("Policy1")]
        [Route("/contas")]
        
        public IActionResult Get(
            [FromServices] AppDbContext context)
        {
            return Ok(context.Contas!.ToList());
        }

        [HttpPost]
        [Route("/loginAsync")]        
        public IActionResult LoginAsync(
            [FromBody] LoginAsyncDTO User,
            [FromServices] AppDbContext context)
        {
            var contasModel = context.Contas!.Include(a => a.Usuario).
            FirstOrDefault(x => x.NomeUsuario == User.Name 
            && x.Senha == User.Password);

            if (contasModel == null){
                return NotFound("Usuario ou senha não encontrado");
            }
            return Ok(contasModel);
        }

        [HttpPost("/registerAsync")]
        [EnableCors("Policy1")]

        public IActionResult RegisterAsync([FromBody] ContaEntradaDTO contaModel, [FromServices] AppDbContext context){
            var model = context.Contas!.ToList();

            foreach(var contas in model){
                if (contas.NomeUsuario == contaModel.NomeUsuario){
                    return Conflict("Nome de usuário já registrado");
                }
            }
        
            ContaModel conta = new ContaModel
            {
                ID = model.Count > 0 ? model.Last().ID + 1 : 0,
                NomeUsuario = contaModel.NomeUsuario,
                Senha = contaModel.Senha
            };

            context.Contas!.Add(conta);
            context.SaveChanges();
            return Created($"/{conta.ID}", conta);
        }
        
        [HttpPut("/editAccountAsync")]
        public IActionResult EditAccountAsync( 
        [FromBody] EditContaDTO contaModel,
        [FromServices] AppDbContext context){
            var model = context.Contas!.Include(a => a.Usuario).FirstOrDefault(x => x.ID == contaModel.Id);
            if (model == null){
                return NotFound();
            }

            if (model.Senha != contaModel.Password){
                return Conflict("Senha informada não corresponde com a atual.");
            }

            try{
                var item = context.Contas!.First(x => x.NomeUsuario == contaModel.Name);
                if (item != null && item.ID != contaModel.Id){
                    return Conflict("Já existe usuário com esse username.");
                }
            }catch{
            }

            model.NomeUsuario = contaModel.Name;
            if (!String.IsNullOrEmpty(contaModel.NewPassword) && !String.IsNullOrWhiteSpace(contaModel.NewPassword)){
                model.Senha = contaModel.NewPassword;
            }

            context.Contas!.Update(model);
            context.SaveChanges();
            return Ok(model);
        }

        [HttpDelete("/contas/{id:int}")] 
        public IActionResult Delete([FromRoute] int id,
        [FromServices] AppDbContext context){
            var model = context.Contas!.FirstOrDefault(x => x.ID == id);
            if (model == null){
                return NotFound();
            }

            context.Contas!.Remove(model);
            context.SaveChanges();
            return Ok(model);
        }
    }
}