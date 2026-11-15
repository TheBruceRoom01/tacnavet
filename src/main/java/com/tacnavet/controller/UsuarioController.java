package com.tacnavet.controller;

import com.tacnavet.model.Usuario;
import com.tacnavet.repository.UsuarioRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
//CRUD PARA USUARIOS

@Controller
@RequestMapping("/sistema/usuarios")
public class UsuarioController {

    private final UsuarioRepository usuarioRepository;

    public UsuarioController(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    // LISTAR
    @GetMapping({"", "/"})
    public String listar(Model model) {
        model.addAttribute("usuarios", usuarioRepository.findAll());
        return "sistema/usuarios/listar";
    }

    // FORMULARIO NUEVO
    @GetMapping("/nuevo")
    public String nuevo(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "sistema/usuarios/formulario";
    }

    // GUARDAR (crear o actualizar)
    @PostMapping("/guardar")
    public String guardar(@ModelAttribute Usuario usuario) {
        if (usuario.getId() == null) {
            usuario.setFechaRegistro(LocalDate.now());
        } else {
            // al editar, conservar la fecha de registro original
            usuarioRepository.findById(usuario.getId())
                    .ifPresent(u -> usuario.setFechaRegistro(u.getFechaRegistro()));
        }
        usuarioRepository.save(usuario);
        return "redirect:/sistema/usuarios";
    }

    // FORMULARIO EDITAR
    @GetMapping("/editar/{id}")
    public String editar(@PathVariable Integer id, Model model) {
        usuarioRepository.findById(id).ifPresent(u -> model.addAttribute("usuario", u));
        return "sistema/usuarios/formulario";
    }

    // ELIMINAR
    @GetMapping("/eliminar/{id}")
    public String eliminar(@PathVariable Integer id) {
        try {
            usuarioRepository.deleteById(id);
        } catch (Exception e) {
            // el usuario tiene citas registradas (FK)
            return "redirect:/sistema/usuarios?errorFK";
        }
        return "redirect:/sistema/usuarios";
    }
}