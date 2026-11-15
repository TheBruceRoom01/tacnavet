package com.tacnavet.controller;

import com.tacnavet.model.Cliente;
import com.tacnavet.model.Mascota;
import com.tacnavet.repository.ClienteRepository;
import com.tacnavet.repository.MascotaRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
//CRUD PARA MASCOTAS


@Controller
@RequestMapping("/sistema/mascotas")
public class MascotaController {

    private final MascotaRepository mascotaRepository;
    private final ClienteRepository clienteRepository;

    public MascotaController(MascotaRepository mascotaRepository, ClienteRepository clienteRepository) {
        this.mascotaRepository = mascotaRepository;
        this.clienteRepository = clienteRepository;
    }

    // LISTAR
    @GetMapping({"", "/"})
    public String listar(Model model) {
        model.addAttribute("mascotas", mascotaRepository.findAll());
        return "sistema/mascotas/listar";
    }

    // FORMULARIO NUEVO
    @GetMapping("/nuevo")
    public String nuevo(Model model) {
        model.addAttribute("mascota", new Mascota());
        model.addAttribute("clientes", clienteRepository.findAll());
        return "sistema/mascotas/formulario";
    }

    // GUARDAR (crear o actualizar)
    @PostMapping("/guardar")
    public String guardar(@ModelAttribute Mascota mascota, @RequestParam Integer clienteId) {
        Cliente cliente = clienteRepository.findById(clienteId).orElse(null);
        if (cliente == null) {
            return "redirect:/sistema/mascotas";
        }
        mascota.setCliente(cliente);
        mascotaRepository.save(mascota);
        return "redirect:/sistema/mascotas";
    }

    // FORMULARIO EDITAR
    @GetMapping("/editar/{id}")
    public String editar(@PathVariable Integer id, Model model) {
        mascotaRepository.findById(id).ifPresent(m -> model.addAttribute("mascota", m));
        model.addAttribute("clientes", clienteRepository.findAll());
        return "sistema/mascotas/formulario";
    }

    // ELIMINAR
    @GetMapping("/eliminar/{id}")
    public String eliminar(@PathVariable Integer id) {
        try {
            mascotaRepository.deleteById(id);
        } catch (Exception e) {
            // la mascota tiene citas registradas (FK)
            return "redirect:/sistema/mascotas?errorFK";
        }
        return "redirect:/sistema/mascotas";
    }
}