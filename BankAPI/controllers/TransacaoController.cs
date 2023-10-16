using BankAPI.Models;
using BankAPI.Data;
using Microsoft.AspNetCore.Mvc;

namespace Events.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TransacaoController : ControllerBase
    {
        [HttpGet]
        [Route("/transacoes")]
        public IActionResult Get(
            [FromServices] AppDbContext context)
        {
            return Ok(context.Transacoes!.ToList());
        }

        [HttpGet]
        [Route("/transacoes/{id:int}")]
        public IActionResult Get(
            [FromRoute] int id,
            [FromServices] AppDbContext context)
        {
            var transacaoModel = context.Transacoes!.FirstOrDefault(x => x.ID == id);
            if (transacaoModel == null){
                return NotFound();
            }
            return Ok(transacaoModel);
        }

        [HttpPost("/transacoes")]
        public IActionResult Post([FromBody] TransacaoModel transacaoModel, [FromServices] AppDbContext context){
            var model = context.Transacoes!.ToList();

            transacaoModel.ID = model.Last().ID++;
            context.Transacoes!.Add(transacaoModel);
            context.SaveChanges();
            return Created($"/{transacaoModel.ID}", transacaoModel);
        }

        [HttpPut("/transacoes")]
        public IActionResult Put( 
        [FromBody] TransacaoModel transacaoModel,
        [FromServices] AppDbContext context){
            var model = context.Transacoes!.FirstOrDefault(x => x.ID == transacaoModel.ID);
                if (model == null){
                    return NotFound();
                }

                model.DescricaoCompra = transacaoModel.DescricaoCompra;
                model.Pago = transacaoModel.Pago;
                model.Valor = transacaoModel.Valor;

                context.Transacoes!.Update(model);
                context.SaveChanges();
                return Ok(model);
        }

        [HttpDelete("/transacoes/{id:int}")] 
        public IActionResult Delete([FromRoute] int id,
        [FromServices] AppDbContext context){
            var model = context.Transacoes!.FirstOrDefault(x => x.ID == id);
            if (model == null){
                return NotFound();
            }

            context.Transacoes!.Remove(model);
            context.SaveChanges();
            return Ok(model);
        }
    }
}