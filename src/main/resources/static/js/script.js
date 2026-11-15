document.addEventListener('DOMContentLoaded', function () {

  // MENÚ HAMBURGUESA 
  
  const botonMenu = document.getElementById('boton-menu');
  const menu = document.getElementById('menu');
  const fondoMenu = document.getElementById('fondo-menu');
  const enlacesNav = document.querySelectorAll('[data-nav-link]');

  function abrirMenu() {
    menu.classList.add('abierto');
    fondoMenu.classList.add('visible');
    botonMenu.setAttribute('aria-expanded', 'true');
    botonMenu.setAttribute('aria-label', 'Cerrar menú');
    document.body.style.overflow = 'hidden';
  }

  function cerrarMenu() {
    menu.classList.remove('abierto');
    fondoMenu.classList.remove('visible');
    botonMenu.setAttribute('aria-expanded', 'false');
    botonMenu.setAttribute('aria-label', 'Abrir menú');
    document.body.style.overflow = '';
  }

  botonMenu.addEventListener('click', function () {
    menu.classList.contains('abierto') ? cerrarMenu() : abrirMenu();
  });

  fondoMenu.addEventListener('click', cerrarMenu);

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') cerrarMenu();
  });

  enlacesNav.forEach(function (link) {
    link.addEventListener('click', cerrarMenu);
  });

  
  // SOMBRA EN EL HEADER AL HACER SCROLL
 
  const nav = document.getElementById('nav');

  function actualizarNav() {
    nav.classList.toggle('desplazado', window.scrollY > 10);
  }

  window.addEventListener('scroll', actualizarNav);
  actualizarNav();

  
  // RESALTAR EL LINK ACTIVO (scroll spy)
  
  const secciones = document.querySelectorAll('main section[id]');

  const observadorSecciones = new IntersectionObserver(function (entradas) {
    entradas.forEach(function (entrada) {
      if (entrada.isIntersecting) {
        const id = entrada.target.getAttribute('id');
        enlacesNav.forEach(function (link) {
          const coincide = link.getAttribute('href') === '#' + id;
          link.classList.toggle('activo', coincide);
        });
      }
    });
  }, {
    rootMargin: '-40% 0px -55% 0px',
    threshold: 0
  });

  secciones.forEach(function (seccion) {
    observadorSecciones.observe(seccion);
  });

 
  // ANIMACIÓN DE REVELADO AL HACER SCROLL
 
  const elementosRevelar = document.querySelectorAll('[data-reveal]');

  const observadorRevelado = new IntersectionObserver(function (entradas) {
    entradas.forEach(function (entrada) {
      if (entrada.isIntersecting) {
        entrada.target.classList.add('visible');
        observadorRevelado.unobserve(entrada.target);
      }
    });
  }, { threshold: 0.15 });

  elementosRevelar.forEach(function (el) {
    observadorRevelado.observe(el);
  });

  
  // TESTIMONIOS
 
  const track = document.getElementById('track-testimonios');
  const contenedorPuntos = document.getElementById('puntos-testimonios');
  const tarjetas = track ? Array.from(track.children) : [];

  if (track && contenedorPuntos && tarjetas.length > 0) {
    // Generar puntos
    tarjetas.forEach(function (_, indice) {
      const punto = document.createElement('button');
      punto.classList.add('punto');
      punto.setAttribute('aria-label', 'Ir al testimonio ' + (indice + 1));
      if (indice === 0) punto.classList.add('activo');

      punto.addEventListener('click', function () {
        tarjetas[indice].scrollIntoView({ behavior: 'smooth', inline: 'start', block: 'nearest' });
      });

      contenedorPuntos.appendChild(punto);
    });

    const puntos = Array.from(contenedorPuntos.children);

    // Detectar cuál tarjeta está visible
    const observadorCarrusel = new IntersectionObserver(function (entradas) {
      entradas.forEach(function (entrada) {
        if (entrada.isIntersecting) {
          const indice = tarjetas.indexOf(entrada.target);
          puntos.forEach(function (dot, i) {
            dot.classList.toggle('activo', i === indice);
          });
        }
      });
    }, {
      root: track,
      threshold: 0.6
    });

    tarjetas.forEach(function (tarjeta) {
      observadorCarrusel.observe(tarjeta);
    });
  }

  // BOTONES QUE PRESELECCIONAN EL SERVICIO EN EL FORMULARIO
  const selectServicio = document.getElementById('servicio');
  const botonesServicio = document.querySelectorAll('[data-service]');

  botonesServicio.forEach(function (boton) {
    boton.addEventListener('click', function () {
      const servicioElegido = boton.getAttribute('data-service');
      if (selectServicio && servicioElegido) {
        const opciones = Array.from(selectServicio.options).map(function (o) { return o.value; });
        if (opciones.includes(servicioElegido)) {
          selectServicio.value = servicioElegido;
        }
      }

      const destino = boton.getAttribute('data-scroll-to');
      if (destino) {
        const elementoDestino = document.querySelector(destino);
        if (elementoDestino) {
          elementoDestino.scrollIntoView({ behavior: 'smooth' });
        }
      }
    });
  });


  // VALIDACIÓN Y ENVÍO DEL FORMULARIO DE CONTACTO
  const form = document.getElementById('form-contacto');
  const formExito = document.getElementById('exito-form');

  const nombreInput = document.getElementById('nombre');
  const correoInput = document.getElementById('correo');
  const mensajeInput = document.getElementById('mensaje');

  const errorNombre = document.getElementById('error-nombre');
  const errorCorreo = document.getElementById('error-correo');
  const errorMensaje = document.getElementById('error-mensaje');

  const regexEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  function mostrarError(input, spanError, mensaje) {
    input.closest('.form-grupo').classList.add('error');
    spanError.textContent = mensaje;
  }

  function limpiarError(input, spanError) {
    input.closest('.form-grupo').classList.remove('error');
    spanError.textContent = '';
  }

  function validarFormulario() {
    let esValido = true;

    if (nombreInput.value.trim().length < 3) {
      mostrarError(nombreInput, errorNombre, 'Ingresa tu nombre completo (mínimo 3 caracteres).');
      esValido = false;
    } else {
      limpiarError(nombreInput, errorNombre);
    }

    if (!regexEmail.test(correoInput.value.trim())) {
      mostrarError(correoInput, errorCorreo, 'Ingresa un correo electrónico válido.');
      esValido = false;
    } else {
      limpiarError(correoInput, errorCorreo);
    }

    if (mensajeInput.value.trim().length < 10) {
      mostrarError(mensajeInput, errorMensaje, 'Cuéntanos un poco más (mínimo 10 caracteres).');
      esValido = false;
    } else {
      limpiarError(mensajeInput, errorMensaje);
    }

    return esValido;
  }

  // Validar en tiempo real al perder el foco
  [nombreInput, correoInput, mensajeInput].forEach(function (input) {
    input.addEventListener('blur', validarFormulario);
  });

  form.addEventListener('submit', function (e) {
    e.preventDefault();

    if (!validarFormulario()) {
      const primerError = form.querySelector('.error .form-input, .error .form-textarea');
      if (primerError) primerError.focus();
      return;
    }

    // envío exitoso
    formExito.hidden = false;
    formExito.scrollIntoView({ behavior: 'smooth', block: 'center' });

    form.reset();

    setTimeout(function () {
      formExito.hidden = true;
    }, 6000);
  });


  // BOTÓN "VOLVER ARRIBA"
  const botonSubir = document.getElementById('boton-subir');

  function actualizarBotonSubir() {
    botonSubir.classList.toggle('visible', window.scrollY > 500);
  }

  window.addEventListener('scroll', actualizarBotonSubir);
  actualizarBotonSubir();

  botonSubir.addEventListener('click', function () {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });

   // AÑO ACTUAL EN EL PIE DE PÁGINA
  const spanAnio = document.getElementById('anio-actual');
  if (spanAnio) {
    spanAnio.textContent = new Date().getFullYear();
  }

});