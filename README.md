# ShipSticks Ruby on Rails Challenge

### **Instructions to Run the App Locally**

Follow these steps to set up and run the app on your local machine.

---

#### **Prerequisites**
- **Docker**: Ensure you have Docker installed. [Download Docker](https://www.docker.com/products/docker-desktop/).
- **Git**: Ensure Git is installed for cloning the repository. [Download Git](https://git-scm.com/).

---

#### **1. Clone the Repository**
Fork and clone the repository to your local machine:
```bash
git clone ssh://git@github.com/michaelirick/shipsticks-coding-challenge
cd shipsticks-coding-challenge
```

---

#### **2. Set Up Docker**
Ensure Docker is installed and running. You can verify this by running:
```bash
docker --version
docker-compose --version
```

---

#### **3. Start the App**
Run the following command to start the application using Docker Compose:
```bash
docker-compose up -d
```

This command will:
1. Build the required Docker images.
2. Launch three containers:
   - **Rails API App**: Runs the backend application on `http://localhost:3000`.
   - **MongoDB Instance**: Hosts the database on `localhost:27017`.
   - **Vite Dev Server**: Serves the frontend application on `http://localhost:3036`.

---

#### **4. Verify Containers**
To ensure all containers are running:
```bash
docker ps
```

You should see three containers corresponding to the Rails app, MongoDB, and Vite Dev Server.

---

#### **5. Access the App**
- **Backend API**: Visit `http://localhost:3000` to access the Rails API home page.
- **Frontend App**: Visit `http://localhost:3036` to interact with the Vite-powered frontend (if applicable).

---

#### **6. Stopping the App**
To stop the app and shut down all containers:
```bash
docker-compose down
```
