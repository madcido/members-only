module SessionsHelper

    def logged_in?
        return true if current_user
        false
    end

    def log_in(user)
        session[:id] = user.id
    end

    def remember(user)
        user.remember
        cookies.permanent.signed[:id] = user.id
        cookies.permanent[:token] = user.remember_token
    end

    def log_out(user)
        user.forget
        session.delete(:id)
        cookies.delete(:id)
        cookies.delete(:token)
        @current_user = nil
    end
    
    def current_user
        if session[:id]
            @current_user ||= User.find_by(id: session[:id])
        elsif cookies.signed[:id]
            user = User.find_by(id: cookies[:id])
            if user&.authenticated?(cookies[:token])
                log_in user
                @current_user = user
            end
        end
    end
    
end
