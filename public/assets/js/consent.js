// Consentimiento de cookies (RGPD) + carga condicional de AdSense.
// Los anuncios NO se cargan hasta que el usuario acepta.
(function () {
  var CLAVE = "bv-consent";
  var CLIENTE = "ca-pub-0000000000000000"; // <- reemplazar por tu client ID real

  function cargarAnuncios() {
    if (window.__adsCargados) return;
    window.__adsCargados = true;

    var s = document.createElement("script");
    s.async = true;
    s.crossOrigin = "anonymous";
    s.src = "https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=" + CLIENTE;
    document.head.appendChild(s);

    // Inicializa cada unidad presente en la página.
    document.querySelectorAll(".adsbygoogle").forEach(function () {
      (window.adsbygoogle = window.adsbygoogle || []).push({});
    });
  }

  function ocultarBanner() {
    var b = document.getElementById("consent-banner");
    if (b) b.hidden = true;
  }

  function mostrarBanner() {
    var b = document.getElementById("consent-banner");
    if (b) b.hidden = false;
  }

  function leer() {
    try { return localStorage.getItem(CLAVE); } catch (e) { return null; }
  }

  function guardar(v) {
    try { localStorage.setItem(CLAVE, v); } catch (e) {}
  }

  document.addEventListener("DOMContentLoaded", function () {
    var estado = leer();

    if (estado === "aceptado") {
      cargarAnuncios();
      return;
    }
    if (estado === "rechazado") {
      return;
    }
    mostrarBanner();
  });

  document.addEventListener("click", function (ev) {
    var t = ev.target;
    if (!t || !t.dataset) return;

    if (t.dataset.consent === "aceptar") {
      guardar("aceptado");
      ocultarBanner();
      cargarAnuncios();
    } else if (t.dataset.consent === "rechazar") {
      guardar("rechazado");
      ocultarBanner();
    } else if (t.dataset.consent === "config") {
      var panel = document.getElementById("consent-detalle");
      if (panel) panel.hidden = !panel.hidden;
    }
  });
})();
