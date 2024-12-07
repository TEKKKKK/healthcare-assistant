async function submitQuery() {
    const queryInput = document.getElementById('queryInput');
    const responseArea = document.getElementById('responseArea');
    const submitButton = document.querySelector('button');
    
    // Disable button and show loading state
    submitButton.disabled = true;
    responseArea.innerHTML = 'Processing query...';
    
    try {
        const response = await fetch('http://localhost:8000/query', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                text: queryInput.value
            })
        });
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        responseArea.innerHTML = data.response;
    } catch (error) {
        console.error('Error:', error);
        responseArea.innerHTML = `Error: ${error.message}. Please ensure the server is running and try again.`;
    } finally {
        submitButton.disabled = false;
    }
}

// Test connection on page load
window.addEventListener('load', async () => {
    try {
        const response = await fetch('http://localhost:8000/health');
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        console.log('Backend connection successful');
    } catch (error) {
        console.error('Backend connection failed:', error);
        document.getElementById('responseArea').innerHTML = 
            'Unable to connect to the backend server. Please ensure it is running.';
    }
});