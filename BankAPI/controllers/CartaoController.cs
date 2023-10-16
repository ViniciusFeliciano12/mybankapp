using BankAPI.Models;
using BankAPI.Data;
using Microsoft.AspNetCore.Mvc;
using BankAPI.DTO;

namespace Events.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CartaoController : ControllerBase
    {
        [HttpGet]
        [Route("/cartoes")]
        public IActionResult Get(
            [FromServices] AppDbContext context)
        {
            return Ok(context.Cartoes!.ToList());
        }

        [HttpGet]
        [Route("/cartoes/{id:int}")]
        public IActionResult Get(
            [FromRoute] int id,
            [FromServices] AppDbContext context)
        {
            var cartoesModel = context.Cartoes!.FirstOrDefault(x => x.ID == id);
            if (cartoesModel == null){
                return NotFound();
            }
            return Ok(cartoesModel);
        }

        [HttpPost("/cartoes")]
        public IActionResult Post([FromBody] CartaoEntradaDTO cartaoModel, [FromServices] AppDbContext context){
            var model = context.Cartoes!.ToList();

            CartaoModel cartao = new CartaoModel
            {
                ID = model.Last().ID++,
                CreditoDisponivel = cartaoModel.CreditoDisponivel,
                Numero = cartaoModel.Numero,
                Senha = cartaoModel.Senha
            };

            context.Cartoes!.Add(cartao);
            context.SaveChanges();
            return Created($"/{cartao.ID}", cartaoModel);
        }

        [HttpPut("/cartoes")]
        public IActionResult Put( 
        [FromBody] CartaoModel cartaoModel,
        [FromServices] AppDbContext context){
            var model = context.Cartoes!.FirstOrDefault(x => x.ID == cartaoModel.ID);
                if (model == null){
                    return NotFound();
                }

                model.CreditoDisponivel = cartaoModel.CreditoDisponivel;
                model.Senha = cartaoModel.Senha;
                model.Faturas = cartaoModel.Faturas;
                model.Numero = cartaoModel.Numero;

                context.Cartoes!.Update(model);
                context.SaveChanges();
                return Ok(model);
        }

        [HttpDelete("/cartoes/{id:int}")] 
        public IActionResult Delete([FromRoute] int id,
        [FromServices] AppDbContext context){
            var model = context.Cartoes!.FirstOrDefault(x => x.ID == id);
            if (model == null){
                return NotFound();
            }

            context.Cartoes!.Remove(model);
            context.SaveChanges();
            return Ok(model);
        }
    }
}