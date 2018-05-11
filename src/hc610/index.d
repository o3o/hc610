module hc610.index;

version (unittest) {
   import unit_threaded;
}
import std.conv;

import vibe.d;


final class IndexController {
   private IndexModel indexModel;

   this(IndexModel indexModel) {
      assert(indexModel !is null);
      this.indexModel = indexModel;
   }

   // GET /
   void index() {
      auto model = indexModel;
      render!("index.dt", model);
   }

   @path("/timedata") void getData() {

   }

   @path("chart/:index")
   void getChartWS(scope WebSocket socket, int _index) {
      logInfo("getChartWS:%d - Connect", _index);

      while (true) {
         try {
            if (!socket.connected) break;

            string message = socket.receiveText();
            logInfo("msg: %s", message);
            Json j = parseJsonString(message);
            if (j["action"].get!string == "rqs") {
               int ts = j["time_span"].get!int;
               int offset = j["offset"].get!int;
               auto data = indexModel.getData(_index, ts, offset);
               socket.send(data);
            } else if (message == "close") {
               logInfo("ChartController:getChartWS:%d - close", _index);
               break;
            }
         } catch (Exception e) {
            logError("ChartController:getChartWS:%d ERROR %s", _index, e.msg);
         }
      }
      logInfo("ChartController:getChartWS:%d disconnected", _index);
   }
}

class IndexModel {
   string getData(int i, int ts, int o) {
      return  `[
         [
         ["2018-05-10T19:53:36.993Z",0.2726964898902562],
         ["2018-05-10T19:53:37.993Z",2.19405170270784  ],
         ["2018-05-10T19:53:38.993Z",1.0798116006661673],
         ["2018-05-10T19:53:39.993Z",1.0289763027285415],
         ["2018-05-10T19:53:40.993Z",-4.128149669474372],
         ["2018-05-10T19:53:41.993Z",-4.562501876679736],
         ["2018-05-10T19:53:42.993Z",-1.227137623358045],
         ["2018-05-10T19:53:43.993Z",1.7854399319127223],
         ["2018-05-10T19:53:44.993Z",-4.911575062789877],
         ["2018-05-10T19:53:45.993Z",3.5556498033763106]
         ]
            ]
         `;
   }
}
