part of boardytale_server;


class TalesController extends HTTPController {

//  @httpGet
//  Future<Response> getAllQuestions() async {
//    return new Response.ok(questions);
//  }

  @httpGet
  Future<Response> getTaleAtIndex(@HTTPPath("index") int index) async {
    String path = "web/tales/$index.json";
    File tale = new File(path);
    if(tale.existsSync()){
      return new Response.ok(tale.readAsStringSync())..contentType = ContentType.JSON;;
    }else{
      return new Response.notFound();
    }

  }
}