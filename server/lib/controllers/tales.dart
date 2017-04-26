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
      String output = tale.readAsStringSync();
      // TODO: copy tale assets to webserver - it is silly to decode and encode (AQUEDUCT should make something with this)
      return new Response.ok(JSON.decode(output))..contentType = ContentType.JSON;
    }else{
      return new Response.notFound();
    }

  }
}