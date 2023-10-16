using BankAPI.Models;
using BankAPI.Data;
using Microsoft.AspNetCore.Mvc;
using BankAPI.DTO;

namespace Events.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ContaController : ControllerBase
    {
        [HttpGet]
        [Route("/contas")]
        public IActionResult Get(
            [FromServices] AppDbContext context)
        {
            return Ok(context.Contas!.ToList());
        }

        [HttpGet]
        [Route("/contas/{id:int}")]
        public IActionResult Get(
            [FromRoute] int id,
            [FromServices] AppDbContext context)
        {
            var contasModel = context.Contas!.FirstOrDefault(x => x.ID == id);
            if (contasModel == null){
                return NotFound();
            }
            return Ok(contasModel);
        }

        [HttpPost("/contas")]
        public IActionResult Post([FromBody] ContaEntradaDTO contaModel, [FromServices] AppDbContext context){
            var model = context.Contas!.ToList();

            ContaModel conta = new ContaModel
            {
                ID = model.Count > 0 ? model.Last().ID++ : 0,
                NomeUsuario = contaModel.NomeUsuario,
                Senha = contaModel.Senha
            };

            context.Contas!.Add(conta);
            context.SaveChanges();
            return Created($"/{conta.ID}", conta);
        }
        
        [HttpPut("/contas")]
        public IActionResult Put( 
        [FromBody] ContaModel contaModel,
        [FromServices] AppDbContext context){
            var model = context.Contas!.FirstOrDefault(x => x.ID == contaModel.ID);
                if (model == null){
                    return NotFound();
                }

                model.NomeUsuario = contaModel.NomeUsuario;
                model.Senha = contaModel.Senha;
                model.Usuario = contaModel.Usuario;

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