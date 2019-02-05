package it.lisit.siss.flex.component.accordion
{
	
	import mx.controls.Button;
	import mx.core.mx_internal;

	use namespace mx_internal;

	[Exclude(name="emphasized", kind="property")]
	[Exclude(name="toggle", kind="property")]
	[DefaultBindingProperty(source="selected", destination="selected")]
	[DefaultTriggerEvent("click")]

	public class CustomButton extends Button
	{
		public function CustomButton()
		{
			super();
			 _toggle = true;
		}
		/**
	     *  @private
	     *  A CheckBox doesn't have an emphasized state, so _emphasized
	     *  is set false in the constructor and can't be changed via this setter.
	     */
	    override public function set emphasized(value:Boolean):void
	    {
	    }
	}
}