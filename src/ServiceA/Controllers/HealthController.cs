using Microsoft.AspNetCore.Mvc;
namespace ServiceA.Controllers
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
