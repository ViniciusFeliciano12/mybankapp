using BankAPI.Models;
using BankAPI.Data;
using Microsoft.AspNetCore.Mvc;
using BankAPI.DTO;
using MyBank.DTO;
using Microsoft.EntityFrameworkCore;

namespace Events.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PixController : ControllerBase
    {
        [HttpGet]
        [Route("/pix")]
        public IActionResult Get(
            [FromServices] AppDbContext context)
        {
            return Ok(context.Pix!.ToList());
        }

        [HttpPost]
        [Route("/verificarChavePixAsync")]
        public IActionResult VerificarChavePixAsync(
            [FromBody] string chavePIX,
            [FromServices] AppDbContext context)
        {
            UsuarioModel? conta;
            try{
                conta = context.Usuarios!.Where(a => a.ChavePIX == chavePIX).First();
            }catch{
                return NotFound("Chave pix não achada.");
            }
            VerificarChavePixDTO contaAchada = new VerificarChavePixDTO
            {
                ChavePIX = conta.ChavePIX,
                Nome = conta.Nome,
                Sobrenome = conta.Sobrenome
            };
            return Ok(contaAchada);
        }

        [HttpPost("/fazerPixAsync")]
        public IActionResult FazerPixAsync(
            [FromBody] FazerPixDTO pixModel, 
            [FromServices] AppDbContext context){
            var model = context.Pix!.ToList();
            UsuarioModel recebinte;
            UsuarioModel pagante;
            ContaModel? conta;
            try{
                recebinte = context.Usuarios!.Where(a => a.ChavePIX == pixModel.ChavePixRecebinte).First();
                pagante = context.Usuarios!.Where(a => a.ID == pixModel.IDPagante).First();
                conta = context.Contas!.Include(a => a.Usuario).FirstOrDefault(x => x.Usuario!.ID == pixModel.IDPagante);
            }catch(Exception ex){
                return NotFound(ex.Message);
            }
            if (pixModel.Password != conta!.Senha){
                return Conflict("Senha não confere com a informada.");
            }
            if (pagante.Dinheiro < pixModel.Valor){
                return Conflict("Não há dinheiro suficiente na conta para realizar essa transação.");
            }

            pagante.Dinheiro -= pixModel.Valor;
            recebinte.Dinheiro += pixModel.Valor;

            PixModel pix = new()
            {
                ID = model.Count == 0 ? 0 : model.Last().ID+1,
                IDPagante = pagante.ID,
                IDRecebinte = recebinte.ID,
                Valor = pixModel.Valor
            };

            context.Pix!.Add(pix);
            context.SaveChanges();
            return Created($"/{conta}", conta);
        }

        [HttpPost("/editarChavePixAsync")]
        public IActionResult EditarChavePixAsync(
            [FromBody] EditarChavePixDTO pixModel, 
            [FromServices] AppDbContext context){

            var model = context.Usuarios!.FirstOrDefault(x => x.ID == pixModel.IdUser);
            var account = context.Contas!.Include(a => a.Usuario).FirstOrDefault(x => x.ID == pixModel.IdAccount);
            try{
                var exists = context.Usuarios!.First(a => a.ChavePIX == pixModel.ChavePIX);
                return Conflict("Chave PIX já cadastrada.");
            }catch{

            }

            if (model == null || account == null){
                return NotFound();
            }
            if (account.Usuario!.ID != pixModel.IdUser){
                return Conflict("ID do usuário enviado não confere com o ID de usuário associado ao ID da conta.");
            }

            if (account.Senha != pixModel.Password){
                return Conflict("Senha informada não confere com a senha da conta.");
            }

            model.ChavePIX = pixModel.ChavePIX;
            account.Usuario.ChavePIX = pixModel.ChavePIX;

            context.Usuarios!.Update(model);
            context.SaveChanges();
            return Ok(account);
        }

        [HttpPost("/getListPixAsync")]
        public IActionResult GetListPixAsync(
            [FromBody] int id, 
            [FromServices] AppDbContext context){

            var historicoDePix = context.Pix!.Where(a => a.IDPagante == id || a.IDRecebinte == id).ToList();

            List<HistoricoPixDTO> lista = new List<HistoricoPixDTO>();

            foreach(var item in historicoDePix){
                HistoricoPixDTO newItem = new HistoricoPixDTO();
                var recebinte = context.Usuarios!.FirstOrDefault(a => a.ID == item.IDRecebinte)!;
                var pagante = context.Usuarios!.FirstOrDefault(a => a.ID == item.IDPagante)!;
                newItem.NomeRecebinte = recebinte.Nome + " " + recebinte.Sobrenome;
                newItem.NomePagante = pagante.Nome + " " + pagante.Sobrenome;
                newItem.Valor = item.Valor;
                newItem.Pagante = pagante.ID == id;
                lista.Add(newItem);
            }
            
            return Ok(lista);
        }
    }
}