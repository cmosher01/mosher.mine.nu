window.addEventListener("load", (event) => {
    const element = document.getElementById("tree");
    const parent = element.parentElement;

    const panzoom = Panzoom(element);

    parent.addEventListener('wheel', panzoom.zoomWithWheel, { passive: false });
}, false);
