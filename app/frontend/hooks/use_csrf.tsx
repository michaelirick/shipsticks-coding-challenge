const useCsrf = (): string | null => {
  const metaTag = document.querySelector('meta[name="csrf-token"]');
  return metaTag ? metaTag.getAttribute('content') : null;
};

export default useCsrf;