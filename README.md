# ShipSticks Ruby on Rails Challenge

## **API Documentation**

This documentation may also be found in `docs/API Documentation.docx`.

---

#### **Schema Overview**
This API provides GraphQL-based functionality for managing products and calculator results, enabling CRUD operations for products, saving calculator results, and retrieving data. The schema includes the following main types: `Product`, `CalculatorResult`, and their associated mutations and queries.

---

### **Types**

#### **CalculatorResult**
Represents a saved calculator result associated with dimensions and a product.

- **Fields**:
  - `createdAt` _(ISO8601DateTime!)_: Timestamp of when the result was created.
  - `height` _(Int!)_: The height of the result in inches.
  - `id` _(ID!)_: Unique identifier of the result.
  - `length` _(Int!)_: The length of the result in inches.
  - `product` _(Product)_: The associated product (optional).
  - `updatedAt` _(ISO8601DateTime!)_: Timestamp of when the result was last updated.
  - `weight` _(Int!)_: The weight of the result in pounds.
  - `width` _(Int!)_: The width of the result in inches.

---

#### **Product**
Represents a product in the catalog.

- **Fields**:
  - `calculatorResults` _([CalculatorResult!]!)_: A list of calculator results associated with the product.
  - `height` _(Int!)_: The height of the product in inches.
  - `id` _(ID!)_: Unique identifier of the product.
  - `length` _(Int!)_: The length of the product in inches.
  - `name` _(String!)_: Name of the product.
  - `type` _(String!)_: The category/type of the product (e.g., Golf, Luggage).
  - `weight` _(Int!)_: The weight of the product in pounds.
  - `width` _(Int!)_: The width of the product in inches.

---

### **Mutations**

#### **`calculatorResultSave(input: CalculatorResultSaveInput!): CalculatorResultSavePayload`**
Saves a calculator result with associated dimensions and product.

- **Input**: 
  - `CalculatorResultSaveInput`:
    - `clientMutationId` _(String)_: Unique identifier for the client performing the mutation.
    - `height` _(Int!)_: Height of the result in inches.
    - `length` _(Int!)_: Length of the result in inches.
    - `productId` _(ID!)_: ID of the associated product.
    - `weight` _(Int!)_: Weight of the result in pounds.
    - `width` _(Int!)_: Width of the result in inches.

- **Response**:
  - `CalculatorResultSavePayload`:
    - `calculatorResult` _(CalculatorResult!)_: The saved calculator result.
    - `clientMutationId` _(String)_: Unique identifier for the client.

---

#### **`productCreate(input: ProductCreateInput!): ProductCreatePayload`**
Creates a new product in the catalog.

- **Input**:
  - `ProductCreateInput`:
    - `clientMutationId` _(String)_: Unique identifier for the client performing the mutation.
    - `height` _(Int!)_: Height of the product in inches.
    - `length` _(Int!)_: Length of the product in inches.
    - `name` _(String!)_: Name of the product.
    - `type` _(String!)_: Type/category of the product.
    - `weight` _(Int!)_: Weight of the product in pounds.
    - `width` _(Int!)_: Width of the product in inches.

- **Response**:
  - `ProductCreatePayload`:
    - `product` _(Product!)_: The created product.
    - `clientMutationId` _(String)_: Unique identifier for the client.

---

#### **`productDelete(input: ProductDeleteInput!): ProductDeletePayload`**
Deletes a product by its ID.

- **Input**:
  - `ProductDeleteInput`:
    - `clientMutationId` _(String)_: Unique identifier for the client performing the mutation.
    - `id` _(ID!)_: ID of the product to delete.

- **Response**:
  - `ProductDeletePayload`:
    - `product` _(Product!)_: The deleted product.
    - `clientMutationId` _(String)_: Unique identifier for the client.

---

#### **`productUpdate(input: ProductUpdateInput!): ProductUpdatePayload`**
Updates an existing product.

- **Input**:
  - `ProductUpdateInput`:
    - `clientMutationId` _(String)_: Unique identifier for the client performing the mutation.
    - `id` _(ID!)_: ID of the product to update.
    - Optional fields for updates:
      - `height` _(Int)_
      - `length` _(Int)_
      - `name` _(String)_
      - `type` _(String)_
      - `weight` _(Int)_
      - `width` _(Int)_

- **Response**:
  - `ProductUpdatePayload`:
    - `product` _(Product!)_: The updated product.
    - `clientMutationId` _(String)_: Unique identifier for the client.

---

### **Queries**

#### **`calculatorResults: [CalculatorResult!]!`**
Retrieves all saved calculator results.

---

#### **`closestProduct(height: Int!, length: Int!, weight: Int!, width: Int!): Product`**
Finds the closest matching product based on the provided dimensions and weight.

- **Arguments**:
  - `height` _(Int!)_: Height of the product in inches.
  - `length` _(Int!)_: Length of the product in inches.
  - `weight` _(Int!)_: Weight of the product in pounds.
  - `width` _(Int!)_: Width of the product in inches.

---

#### **`product(id: ID!): Product`**
Retrieves a product by its unique ID.

- **Arguments**:
  - `id` _(ID!)_: The unique ID of the product.

---

#### **`products(limit: Int = 10, offset: Int = 0, type: String): [Product!]!`**
Retrieves a list of products.

- **Arguments**:
  - `limit` _(Int)_: Maximum number of products to return (default: 10).
  - `offset` _(Int)_: Number of products to skip (default: 0).
  - `type` _(String)_: Filter by product type.


## **Instructions to Run the App Locally**

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
