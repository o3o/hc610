import std.functional: toDelegate;

import vibe.d;

import hc610.index;

void data(HTTPServerRequest req, HTTPServerResponse res) {
   //https://forum.rejectedsoftware.com/groups/rejectedsoftware.vibed/thread/1654/
	res.render!("index.dt", req);
}

void handleRequest(scope HTTPServerRequest req, scope HTTPServerResponse res) {
   string s = `
Time, Value
2018-05-10T19:53:36.993Z,0.2726964898902562
2018-05-10T19:53:37.993Z,2.19405170270784
2018-05-10T19:53:38.993Z,1.0798116006661673
2018-05-10T19:53:39.993Z,1.0289763027285415
2018-05-10T19:53:40.993Z,-4.128149669474372
2018-05-10T19:53:41.993Z,-4.562501876679736
2018-05-10T19:53:42.993Z,-1.227137623358045
2018-05-10T19:53:43.993Z,1.7854399319127223
2018-05-10T19:53:44.993Z,-4.911575062789877
2018-05-10T19:53:45.993Z,3.5556498033763106
      `;
   res.writeBody(s, "text/plain");
}


shared static this() {
   auto router = new URLRouter;
   //router.get("/timedata", &handleRequest);
   router.registerWebInterfaces();

   auto settings = new HTTPServerSettings;
   settings.port = 8080;
   settings.bindAddresses = ["::1", "127.0.0.1"];
   settings.sessionStore = new MemorySessionStore;
   logInfo("start listen");
   try {
      listenHTTP(settings, router);
   } catch (Exception e) {
      logError("app listenHTTP error: %s", e.msg);
      throw e;
   }

   logDiagnostic("end listen");
}

private void registerWebInterfaces(URLRouter router) {
   auto indexM = new IndexModel();

   router.registerWebInterface(new IndexController(indexM));
   logDiagnostic("Index registred");


	//auto fileServerSettings = new HTTPFileServerSettings;
	//fileServerSettings.encodingFileExtension = ["gzip" : ".gz"];
	//router.get("/data/*", serveStaticFiles("./public/", fileServerSettings));

   router.get("*", serveStaticFiles("public"));
   logDiagnostic("app:registerWebInterface - done");
}
