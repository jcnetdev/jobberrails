module Admin::PagesHelper
  def observe_has_form
    observe_field "page_has_form", :frequency => 0.5, 
      :function => "if(element.checked) { 
          Element.show('has_form_label');
          Element.show('has_form_textarea'); 
        } else { 
          Element.hide('has_form_label');Element.hide('has_form_textarea');
        }"
  end
end
