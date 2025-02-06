import 'bootstrap/dist/css/bootstrap.min.css';
import './style.css';

const registerBtn = document.getElementById('registerBtn');
const registerUrl = 'http://127.0.0.1:8080/registrar';
const loginUrl = 'http://127.0.0.1:8080/login';
const login = document.getElementById('login');

if (login) {
    login.addEventListener('click', () => {
        login.setAttribute('hidden', true);
        window.location.href = './src/login.html';
    });
}

const loginBtn = document.getElementById('loginBtn');

const emailInput = document.getElementById('email');
const passwordInput = document.getElementById('password');

export const showAlert = (message, type, timeout = 3500) => {
    alertContainer.innerHTML = `
        <div class="alert alert-${type} alert-dismissible fade show" role="alert" id="bootstrapAlert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    `;

    setTimeout(() => {
        const alertElement = document.getElementById("bootstrapAlert");
        if (alertElement) {
            alertElement.classList.remove("show");
            alertElement.classList.add("fade");
            setTimeout(() => alertElement.remove(), 300);
        }
    }, timeout);
};


const validateInput = (input) => {
    if (input.value.trim() === '') {
        input.classList.remove('is-valid');
        input.classList.add('is-invalid');
    } else {
        input.classList.remove('is-invalid');
        input.classList.add('is-valid');
    }
};

if (emailInput) {
    emailInput.addEventListener('input', () => validateInput(emailInput));
}
if (passwordInput) {
    passwordInput.addEventListener('input', () => validateInput(passwordInput));
}

if (registerBtn) {
    registerBtn.addEventListener('click', async(event) => {
        event.preventDefault();
    
        const email = emailInput.value.trim();
        const password = passwordInput.value.trim();
        let isValid = true;
    
        if (email === '') {
            emailInput.classList.add('is-invalid');
            isValid = false;
        } else {
            emailInput.classList.remove('is-invalid');
            emailInput.classList.add('is-valid');
        }
    
        if (password === '' || password.length < 4) {
            passwordInput.classList.add('is-invalid');
            isValid = false;
        } else {
            passwordInput.classList.remove('is-invalid');
            passwordInput.classList.add('is-valid');
        }
    
        if (!isValid) {
            showAlert('⚠️ Por favor, completa todos los campos correctamente.', 'danger');
            return;
        };
    
        try {
            const response = await fetch(registerUrl, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ email, password })
            });
    
            const data = await response.json();
    
            if (response.ok) {
                showAlert(`✅ ¡Usuario registrado! ${data.msg}`, 'success');
                emailInput.classList.remove('is-valid');
                passwordInput.classList.remove('is-valid');
                emailInput.value = "";
                passwordInput.value = "";
            
                setTimeout(() => {
                    window.location.href = './src/login.html';
                }, 2000);
    
            } else {
                showAlert(`❌ Error: ${data.msg}`, 'danger');
            }
        } catch (error) {
            showAlert("❌ Error en la conexión con el servidor.", 'danger');
        }
    });
}

if (loginBtn) {
    loginBtn.addEventListener('click', async(event) => {
        event.preventDefault();
    
        const email = emailInput.value.trim();
        const password = passwordInput.value.trim();
        let isValid = true;
    
        if (email === '') {
            emailInput.classList.add('is-invalid');
            isValid = false;
        } else {
            emailInput.classList.remove('is-invalid');
            emailInput.classList.add('is-valid');
        }
    
        if (password === '' || password.length < 4) {
            passwordInput.classList.add('is-invalid');
            isValid = false;
        } else {
            passwordInput.classList.remove('is-invalid');
            passwordInput.classList.add('is-valid');
        }
    
        if (!isValid) {
            showAlert('⚠️ Por favor, completa todos los campos correctamente.', 'danger');
            return;
        };
    
        try {
            const response = await fetch(loginUrl, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ email, password })
            });
    
            const data = await response.json();
            console.log(data)
    
            if (response.ok) {
                showAlert('✅ ¡Login realizado con éxito!', 'success');
                emailInput.classList.remove('is-valid');
                passwordInput.classList.remove('is-valid');
                emailInput.value = "";
                passwordInput.value = "";
                localStorage.setItem("usuario", JSON.stringify({
                    id: data.id, 
                    email: data.email, 
                    token: data.token
                }));
            
                setTimeout(() => {
                    window.location.href = 'game.html';
                }, 2000);
    
            } else {
                showAlert(`❌ Error: ${data.msg}`, 'danger');
            }
        } catch (error) {
            showAlert("❌ Error en la conexión con el servidor.", 'danger');
        }
    });
}

const logoutBtn = document.getElementById('logoutBtn');
if (logoutBtn) {
    logoutBtn.addEventListener('click', () => {
        localStorage.removeItem('usuario');
        window.location.href = '/src/login.html';
    });
}

