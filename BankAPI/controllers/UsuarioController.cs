using BankAPI.Models;
using BankAPI.Data;
using Microsoft.AspNetCore.Mvc;
using BankAPI.DTO;

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

        [HttpPost("/usuarios")]
        public IActionResult Post([FromBody] UsuarioEntradaDTO usuarioModel, [FromServices] AppDbContext context){
            var model = context.Usuarios!.ToList();

            UsuarioModel usuario = new UsuarioModel
            {
                ID = model.Last().ID++,
                Cartao = usuarioModel.Cartao,
                ChavePIX = usuarioModel.ChavePIX,
                Dinheiro = usuarioModel.Dinheiro,
                Nome = usuarioModel.Nome,
                Sobrenome = usuarioModel.Sobrenome
            };

            context.Usuarios!.Add(usuario);
            context.SaveChanges();
            return Created($"/{usuario.ID}", usuario);
        }

        [HttpPut("/usuarios")]
        public IActionResult Put( 
        [FromBody] UsuarioModel usuarioModel,
        [FromServices] AppDbContext context){
            var model = context.Usuarios!.FirstOrDefault(x => x.ID == usuarioModel.ID);
                if (model == null){
                    return NotFound();
                }

                model.Cartao = usuarioModel.Cartao;
                model.ChavePIX = usuarioModel.ChavePIX;
                model.Dinheiro = usuarioModel.Dinheiro;
                model.Nome = usuarioModel.Nome;
                model.Sobrenome = usuarioModel.Sobrenome;

                context.Usuarios!.Update(model);
                context.SaveChanges();
                return Ok(model);
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