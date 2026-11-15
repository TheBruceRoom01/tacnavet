package com.tacnavet.controller;

import com.tacnavet.model.Usuario;
import com.tacnavet.repository.UsuarioRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class LoginController {

    private final UsuarioRepository usuarioRepository;

    public LoginController(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @PostMapping("/login")
    public String ingresar(@RequestParam String correo,
                           @RequestParam String contrasena,
                           HttpSession session,
                           Model model) {

        Optional<Usuario> usuario = usuarioRepository.findByCorreoAndContrasena(correo, contrasena);

        if (usuario.isEmpty()) {
            model.addAttribute("error", "Correo o contraseña incorrectos");
            model.addAttribute("correo", correo);
            return "login";
        }

        session.setAttribute("usuarioLog", usuario.get());
        return "redirect:/sistema/usuarios";
    }
}