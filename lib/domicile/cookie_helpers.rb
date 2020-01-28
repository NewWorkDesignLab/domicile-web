module Domicile
  module CookieHelpers
    include ActionController::Cookies
    require "json"

    def scenario_auth_cookie(scenario = nil)
      if scenario.blank?
        cookie = cookies.encrypted[:_domicile_scenario_id]
        if cookie.present?
          parsed = JSON.parse(cookie)
          { value: parsed["value"], time: parsed["time"] }
        end
      else
        json = JSON.generate({ value: scenario[:id], time: scenario[:created_at] })
        cookies.encrypted[:_domicile_scenario_id] = json
      end
    end
  end
end