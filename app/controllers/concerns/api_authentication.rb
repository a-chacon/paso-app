module ApiAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private

  def authenticated?
    resume_session
  end

  def require_authentication
    resume_session || request_authentication
  end

  def resume_session
    Current.session ||= find_session_by_token
  end

  def find_session_by_cookie
    Session.find_by(id: cookies.signed[:session_id]) if cookies.signed[:session_id]
  end

  def find_session_by_token
    Session.find_by(token: request.headers[:authorization]&.split(' ')&.[](-1))
  end

  def request_authentication
    render json: { message: 'Authenticate before use this action.' }, status: :unauthorized
  end

  def after_authentication_url
    session.delete(:return_to_after_authenticating) || root_url
  end

  def start_new_session_for(user)
    user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
      Current.session = session
    end
  end

  def terminate_session
    Current.session.destroy
    cookies.delete(:session_id)
  end
end
