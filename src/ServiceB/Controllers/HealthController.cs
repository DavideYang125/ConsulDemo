using Microsoft.AspNetCore.Mvc;
namespace ServiceB.Controllers
{
    [ApiController]
    [Route("api/[controller]/[action]")]
    public class HealthController : ControllerBase
    {
        [HttpGet]
        public ActionResult Check()
        {
            return Ok("ok");
        }
    }
}
