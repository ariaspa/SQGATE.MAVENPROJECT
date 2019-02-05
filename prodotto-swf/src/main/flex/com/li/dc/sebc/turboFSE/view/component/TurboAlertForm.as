package com.li.dc.sebc.turboFSE.view.component
{
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.alertClasses.*;
	import mx.core.mx_internal;
	import mx.events.CloseEvent;
	
	use namespace mx_internal;
	
	public class TurboAlertForm extends AlertForm
	{
		private var icon:DisplayObject;
		private var defaultButtonChanged:Boolean = false;
		public function TurboAlertForm()
		{
			super();
		}
		private function createButton(label:String, name:String):Button
		{
			var button:Button = new Button();
		
			button.label = label;
		
			// The name is "YES", "NO", "OK", or "CANCEL".
			button.name = name;
		
			var buttonStyleName:String = getStyle("buttonStyleName");
			if (buttonStyleName)
				button.styleName = buttonStyleName;
		
			button.addEventListener(MouseEvent.CLICK, clickHandler);
			button.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		    button.owner = parent;
			addChild(button);
		
			button.setActualSize(Alert.buttonWidth, Alert.buttonHeight);
		
			buttons.push(button);
		
			return button;
		}
		/**
	     *  @private
	     *  On a button click, dismiss the popup and send notification.
	     */
		private function clickHandler(event:MouseEvent):void
		{
			var name:String = Button(event.currentTarget).name;
			removeAlert(name);
		}
		/**
	     *  @private
	     *  Remove the popup and dispatch Click event corresponding to the Button Pressed.
	     */
		private function removeAlert(buttonPressed:String):void
		{
			var alert:Alert = Alert(parent);
	
			alert.visible = false;
	
			var closeEvent:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
			if (buttonPressed == "YES")
				closeEvent.detail = Alert.YES;
			else if (buttonPressed == "NO")
				closeEvent.detail = Alert.NO;
			else if (buttonPressed == "OK")
				closeEvent.detail = Alert.OK;
			else if (buttonPressed == "CANCEL")
				closeEvent.detail = Alert.CANCEL;
			alert.dispatchEvent(closeEvent);
	
			//mx.managers.PopUpManager.removePopUp(alert);
			ViewMessageManager.getInstance().getAreaPopUp().closePopUp();
		}
		/**
		 *  @private
		 */
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			var buttonFlags:uint = Alert(parent).buttonFlags;
	
			if (event.keyCode == Keyboard.ESCAPE)
			{
				if ((buttonFlags & Alert.CANCEL) || !(buttonFlags & Alert.NO))
					removeAlert("CANCEL");
				else if (buttonFlags & Alert.NO)
					removeAlert("NO");
			}
		}
		//////////////////////////////////////////
		override protected function measure():void
		{
			super.measure();
			var prefHeight:Number = 0;
			if (icon)
			{
				prefHeight = icon.height;
			}
			// Limit the height if it exceeds the height of the Stage.
			prefHeight = Math.min(prefHeight, screen.height * 0.75);
			// Add space for buttons, spacing between buttons and text,
			// and top/bottom margins
			prefHeight += buttons[0].height + (3 * 8);	 
			measuredHeight += prefHeight;
		}
		
		override protected function createChildren():void
		{
			// Create the UITextField to display the message.
			createTextField(-1);
		
			// Create the icon object, if any.
			var iconClass:Class = Alert(parent).iconClass;
			if (iconClass && !icon)
			{
				icon = new iconClass();
				addChild(icon);
			}
	
			// Create the button objects
	
			var alert:Alert = Alert(parent);
			
			var buttonFlags:uint = alert.buttonFlags;
			var defaultButtonFlag:uint = alert.defaultButtonFlag;
	
			var label:String;
			var button:Button;
	
			if (buttonFlags & Alert.OK)
			{
				label = String(Alert.okLabel);
				button = createButton(label, "OK");
				if (defaultButtonFlag == Alert.OK)
					defaultButton = button;
			}
	
			if (buttonFlags & Alert.YES)
			{
				label = String(Alert.yesLabel);
				button = createButton(label, "YES");
				if (defaultButtonFlag == Alert.YES)
					defaultButton = button;
			}
	
			if (buttonFlags & Alert.NO)
			{
				label = String(Alert.noLabel);
				button = createButton(label, "NO");
				if (defaultButtonFlag == Alert.NO)
					defaultButton = button;
			}
	
			if (buttonFlags & Alert.CANCEL)
			{
				label = String(Alert.cancelLabel);
				button = createButton(label, "CANCEL");
				if (defaultButtonFlag == Alert.CANCEL)
					defaultButton = button;
			}
	
			if (!defaultButton && buttons.length)
				defaultButton = buttons[0];
	
			// Set the default button to have focus.
			if (defaultButton)
			{
				defaultButtonChanged = true;
				invalidateProperties();
			}
		}
	}
}