using BankAPI.Models;
using BankAPI.Data;
using Microsoft.AspNetCore.Mvc;

namespace Events.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FaturaController : ControllerBase
    {
        [HttpGet]
        [Route("/faturas")]
        public IActionResult Get(
            [FromServices] AppDbContext context)
        {
            return Ok(context.Faturas!.ToList());
        }

        [HttpGet]
        [Route("/faturas/{id:int}")]
        public IActionResult Get(
            [FromRoute] int id,
            [FromServices] AppDbContext context)
        {
            var faturasModel = context.Faturas!.FirstOrDefault(x => x.ID == id);
            if (faturasModel == null){
                return NotFound();
            }
            return Ok(faturasModel);
        }

        [HttpPost("/faturas")]
        public IActionResult Post([FromBody] FaturaModel faturaModel, [FromServices] AppDbContext context){
            var model = context.Faturas!.ToList();

            faturaModel.ID = model.Last().ID++;
            context.Faturas!.Add(faturaModel);
            context.SaveChanges();
            return Created($"/{faturaModel.ID}", faturaModel);
        }

        [HttpPut("/faturas")]
        public IActionResult Put( 
        [FromBody] FaturaModel faturaModel,
        [FromServices] AppDbContext context){
            var model = context.Faturas!.FirstOrDefault(x => x.ID == faturaModel.ID);
                if (model == null){
                    return NotFound();
                }

                model.Mes = faturaModel.Mes;
                model.Pago = faturaModel.Pago;
                model.Transacoes = faturaModel.Transacoes;

                context.Faturas!.Update(model);
                context.SaveChanges();
                return Ok(model);
        }

        [HttpDelete("/faturas/{id:int}")] 
        public IActionResult Delete([FromRoute] int id,
        [FromServices] AppDbContext context){
            var model = context.Faturas!.FirstOrDefault(x => x.ID == id);
            if (model == null){
                return NotFound();
            }

            context.Faturas!.Remove(model);
            context.SaveChanges();
            return Ok(model);
        }
    }
}