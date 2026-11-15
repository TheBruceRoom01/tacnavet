package com.tacnavet.interceptor;

import com.tacnavet.model.Usuario;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuarioLog") : null;

        if (usuario == null) {
            // no hay sesion: fuera del sistema
            response.sendRedirect("/login");
            return false;
        }

        // deja el usuario disponible en todas las vistas del sistema: ${usuarioLog}
        request.setAttribute("usuarioLog", usuario);
        return true;
    }
}