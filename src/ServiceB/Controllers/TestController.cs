using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace ServiceB.Controllers
{
    [ApiController]
    [Route("api/[controller]/[action]")]
    public class TestController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public TestController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet]
        public ActionResult Get()
        {
            var result = new
            {
                ServiceName = "ServiceB",
                msg = $"当前时间：{DateTime.Now:G}",
                //ip = Request HttpContext .Connection.LocalIpAddress.ToString(),
                port = _configuration["Consul:Port"]
            };

            return Ok(result);
        }
    }
}
