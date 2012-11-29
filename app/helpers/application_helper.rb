module ApplicationHelper
$render_str = ""
def create_radio_button(account_details)	
	account_details.each do |account|
		if (account.account_name == "Standard")
		$render_str +="<p><input type='radio' name='account' value='#{account.id}' checked='checked'>#{account.account_name}</input></p>"
		else 
		$render_str +="<p><input type='radio' name='account' value='#{account.id}'>#{account.account_name}</input></p>"
		end
	end
	
end
end
