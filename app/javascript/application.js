document.addEventListener("DOMContentLoaded", function () {
  const interiorBtn = document.getElementById("show-interior");
  const exteriorBtn = document.getElementById("show-exterior");

  interiorBtn.addEventListener("click", () => {
    document.querySelectorAll(".gallery-img").forEach((img) => {
      img.style.display = img.dataset.type === "interior" ? "block" : "none";
    });
  });

  exteriorBtn.addEventListener("click", () => {
    document.querySelectorAll(".gallery-img").forEach((img) => {
      img.style.display = img.dataset.type === "exterior" ? "block" : "none";
    });
  });
});
