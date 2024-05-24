const GetCSRFToken = () => {
    const name = 'csrf-token';
    const csrfToken = document.querySelector(`meta[name="${name}"]`)?.getAttribute('content');
    return csrfToken || '';
}

export default GetCSRFToken