package com.li.dc.sebc.turboFSE.view.component
{
	import flash.display.DisplayObject;
	
	import mx.controls.Alert;
	import mx.controls.alertClasses.*;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	public class TurboAlert extends Alert
	{
		public function TurboAlert()
		{
			super();
		}
		override public function addChild(child:DisplayObject):DisplayObject
	    {
	    	if(child is TurboAlertForm){
	    		return addChildAt(child, numChildren);
	    	}else if(child is AlertForm){
	    		return child;
	    	}
	    	return addChildAt(child, numChildren);	
	    } 
	    
	    override protected function createChildren():void
	    {
	        super.createChildren();
	        alertForm =	null;	
	        if(!alertForm)
	        {
	        	alertForm = new TurboAlertForm();
	        	alertForm.styleName = this;
	            addChild(alertForm);  
	        }
	    }
	}
}