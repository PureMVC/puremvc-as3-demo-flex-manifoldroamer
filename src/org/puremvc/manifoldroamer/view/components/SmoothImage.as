package org.puremvc.manifoldroamer.view.components
{
	import mx.controls.Image;
    import flash.display.Bitmap;
    import mx.controls.Image;
	import flash.system.LoaderContext;
	
	
	public class SmoothImage extends Image
	{
		override public function load(url:Object=null):void
		{
			this.loaderContext = new LoaderContext();
            this.loaderContext.checkPolicyFile = true;
            super.load(url);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(content is Bitmap) {
				var bmp:Bitmap = Bitmap(content);
				if(bmp && bmp.smoothing == false)
				bmp.smoothing = true;
			}
		}
	}
}