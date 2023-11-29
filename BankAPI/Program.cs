using BankAPI.Data;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddDbContext<AppDbContext>();

 builder.Services.AddSwaggerGen();

 builder.Services.AddCors(p => p.AddPolicy("corspolicy", build => {
     build.WithOrigins("http://localhost:5041").WithOrigins("https://localhost:7090").AllowAnyMethod().AllowAnyHeader();
 }));

var app = builder.Build();
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    app.UseDeveloperExceptionPage();
}


app.UseCors("corspolicy");
//app.UseHttpsRedirection();
app.MapControllers();

app.Run();