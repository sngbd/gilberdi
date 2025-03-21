import Lenis from '@studio-freight/lenis';

export function createLenisImpl() {
  return new Lenis({
    duration: 1.2,
    easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
    direction: 'vertical',
    gestureDirection: 'vertical',
    smooth: true,
    mouseMultiplier: 1,
    smoothTouch: false,
    touchMultiplier: 2,
    infinite: false,
  });
}

export function startLenisImpl(lenis) {
  function raf(time) {
    lenis.raf(time);
    requestAnimationFrame(raf);
  }
  requestAnimationFrame(raf);
  return lenis;
}

export function lenisScrollToImpl(lenis, target, options) {
  lenis.scrollTo(target, options);
  return lenis;
}

export function destroyLenisImpl(lenis) {
  return function() {
    lenis.destroy();
  };
}