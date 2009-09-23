package org.puremvc.manifoldroamer.model
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import mx.rpc.http.HTTPService;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.AsyncToken;
	import mx.controls.Alert;

	public class ConfigProxy extends Proxy
	{
		public static const NAME:String = "ConfigProxy";
		public static const CONFIG_READY:String = "configReady";
		protected static const CLIENT_CONFIG:String = "clientConfig";
		protected static const SERVICE_CONFIG:String = "serviceConfig";

		public function ConfigProxy( )
		{
			super( NAME, <config></config> );
			
			// Get Client Configuration immediately
			fetchClientConfig();				   
		}
		
		protected function fetchClientConfig():void
		{
			configService.url = clientConfigURL;
			configService.addEventListener(ResultEvent.RESULT, result);
			configService.addEventListener(FaultEvent.FAULT, fault);
			configService.resultFormat="e4x";
			var token:AsyncToken = configService.send();
			token.config=CLIENT_CONFIG;
		}

		public function result(event:ResultEvent):void
		{
			switch (event.token.config) 
			{
				case CLIENT_CONFIG:
					config.appendChild(event.result as XML);
					configService.url = serviceConfigURL;
					var token:AsyncToken = configService.send();
					token.config=SERVICE_CONFIG;
					break;				
				
				case SERVICE_CONFIG:
					config.appendChild(event.result as XML);
					sendNotification(CONFIG_READY);
					break;				
			}
		}
		
		public function fault(event:FaultEvent):void
		{
			switch (event.token.config) 
			{
				case CLIENT_CONFIG:
					mx.controls.Alert.show('Unable to load: '+clientConfigURL,'No Client Configuration')
					break;				
				
				case SERVICE_CONFIG:
					mx.controls.Alert.show('Unable to load: '+serviceConfigURL,'No Service Configuration')
					break;				
			}
		}

		public function getThumbURL( thumb:String ):String
		{
			if ( thumb.search("http") == 0) return thumb; // don't touch absolutes
			var thumbURL:String = XML(thumbs).@url_pre + thumb + XML(thumbs).@url_post; 
			return thumbURL;	
		}

		public function getRESTServiceURL( nodeID:String ):String
		{
			var restURL:String = XML(service).@url_pre + nodeID + XML(service).@url_post; 
			return restURL;
		}
		
		protected function get clientConfigURL():String
		{
			return "assets/config/ClientConfig.xml";
		}

		protected function get clientConfig():XML
		{
			return config..ClientConfig[0] as XML;
		}

		protected function get serviceConfigURL():String
		{
			return XML(clientConfig..Service[0].@config).toString();
		}

		public function get version():String
		{
			return XML(clientConfig..Service[0].@version).toString();
		}

		protected function get serviceConfig():XML
		{
			return config..ServiceConfig[0];
		}

		protected function get service():XML
		{
			return serviceConfig..Service.(@version == version)[0] as XML;
		}

		public function get root():XML
		{
			return service..Node[0] as XML;
		}

		public function get thumbs():XML
		{
			return service..Thumbs[0] as XML;
		}

		public function get rootID( ):String
		{
			return XML(root.@id).toString();
		}

		protected function get config():XML
		{
			return data as XML;
		}
		
		protected var configService:HTTPService = new HTTPService();
	
	}
}