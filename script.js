const prefersReducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

const nav = document.querySelector("[data-site-nav]");
const toggle = document.querySelector("[data-nav-toggle]");
const header = document.querySelector("[data-site-header]");

const closeNav = () => {
  if (!nav || !toggle) return;
  nav.setAttribute("data-open", "false");
  toggle.setAttribute("aria-expanded", "false");
};

if (nav && toggle) {
  toggle.addEventListener("click", () => {
    const isOpen = nav.getAttribute("data-open") === "true";
    nav.setAttribute("data-open", String(!isOpen));
    toggle.setAttribute("aria-expanded", String(!isOpen));
  });

  nav.querySelectorAll("a").forEach((link) => {
    link.addEventListener("click", closeNav);
  });
}

document.querySelectorAll("[data-current-year]").forEach((node) => {
  node.textContent = new Date().getFullYear();
});

const bootPage = () => {
  document.body.classList.add("is-loaded");
};

if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", bootPage);
} else {
  requestAnimationFrame(bootPage);
}

if (header) {
  const onScroll = () => {
    header.classList.toggle("is-scrolled", window.scrollY > 8);
  };
  onScroll();
  window.addEventListener("scroll", onScroll, { passive: true });
}

const revealElements = document.querySelectorAll(".reveal");

if (revealElements.length && !prefersReducedMotion) {
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-visible");
          observer.unobserve(entry.target);
        }
      });
    },
    { rootMargin: "0px 0px -4% 0px", threshold: 0.08 }
  );
  revealElements.forEach((el) => observer.observe(el));
} else {
  revealElements.forEach((el) => el.classList.add("is-visible"));
}

document.querySelectorAll('img:not([loading]):not([fetchpriority="high"])').forEach((img) => {
  if (img.closest(".lightbox__stage")) return;
  img.loading = "lazy";
  if (!img.decoding) img.decoding = "async";
});

function setupMediaLightbox() {
  const images = document.querySelectorAll(".media-grid .media-frame img");
  if (!images.length) return;

  const dialog = document.createElement("dialog");
  dialog.className = "lightbox";
  dialog.id = "media-lightbox";
  dialog.innerHTML = `
    <div class="lightbox__panel" role="document">
      <div class="lightbox__toolbar">
        <p class="lightbox__title" id="lightbox-title">Project media</p>
        <div class="lightbox__actions">
          <a class="lightbox__btn lightbox__btn--primary" id="lightbox-open" href="#" target="_blank" rel="noopener">Open original</a>
          <button type="button" class="lightbox__btn" id="lightbox-close">Close</button>
        </div>
      </div>
      <div class="lightbox__stage">
        <img class="lightbox__img" id="lightbox-img" alt="" />
      </div>
      <p class="lightbox__caption" id="lightbox-caption"></p>
    </div>
  `;
  document.body.appendChild(dialog);

  const lightboxImg = dialog.querySelector("#lightbox-img");
  const lightboxTitle = dialog.querySelector("#lightbox-title");
  const lightboxCaption = dialog.querySelector("#lightbox-caption");
  const lightboxOpen = dialog.querySelector("#lightbox-open");
  const lightboxClose = dialog.querySelector("#lightbox-close");
  let lastTrigger = null;

  const closeLightbox = () => {
    if (!dialog.open) return;
    dialog.close();
    if (lastTrigger) {
      lastTrigger.focus();
      lastTrigger = null;
    }
  };

  lightboxClose.addEventListener("click", closeLightbox);
  dialog.addEventListener("click", (event) => {
    if (event.target === dialog) closeLightbox();
  });
  dialog.addEventListener("cancel", (event) => {
    event.preventDefault();
    closeLightbox();
  });

  images.forEach((img) => {
    const frame = img.closest(".media-frame");
    if (!frame || frame.classList.contains("media-frame--zoomable")) return;

    const card = img.closest(".media-card");
    const title = card?.querySelector(".media-card__title")?.textContent?.trim() || "";
    const copy = card?.querySelector(".media-card__copy")?.textContent?.trim() || "";

    const zoomBtn = document.createElement("button");
    zoomBtn.type = "button";
    zoomBtn.className = "media-frame media-frame--zoomable";
    zoomBtn.setAttribute(
      "aria-label",
      `View full size: ${img.alt || title || "project image"}`
    );
    frame.replaceWith(zoomBtn);
    zoomBtn.appendChild(img);

    const openLightbox = () => {
      lastTrigger = zoomBtn;
      const src = img.currentSrc || img.src;
      lightboxImg.src = src;
      lightboxImg.alt = img.alt || "";
      lightboxTitle.textContent = title || img.alt || "Project media";
      lightboxCaption.textContent = copy || "";
      lightboxCaption.hidden = !lightboxCaption.textContent;
      lightboxOpen.href = src;
      dialog.showModal();
    };

    zoomBtn.addEventListener("click", openLightbox);
  });
}

setupMediaLightbox();
