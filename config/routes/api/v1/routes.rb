module Api
  module V1
    module Routes
      def self.extended(router)
        router.instance_exec do
          namespace :api do
            namespace :v1 do
              resources :urls, only: [ :create ]
            end
          end

          get "/:short_code", to: "api/v1/urls#redirect", as: :redirect_url
        end
      end
    end
  end
end
