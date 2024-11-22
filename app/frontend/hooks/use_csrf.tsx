const useCsrf = () => {
  return document.querySelector('meta[name="csrf-token"]').getAttribute('content');
};

export default useCsrf;