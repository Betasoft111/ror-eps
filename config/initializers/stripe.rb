#EPS::Application.config.session_store :cookie_store, key: '_EPS_session'
require "stripe"
EPS::Application.config.stripe = {
  :publishable_key => 'pk_test_qTTBTsJuRqCQ8ddkHPqYSKJZ',
  :secret_key      => 'sk_test_9PDt0YXorEKobA7K0aMeStPd'
}

Stripe.api_key = EPS::Application.config.stripe[:secret_key]