using ImageMagick;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();


app.MapGet("/tryme", () =>
{

    using var image = new MagickImage();
        image.Format = MagickFormat.Jpeg;

    return "all good!";
})
.WithName("TryMe")
.WithOpenApi();

app.Run();
