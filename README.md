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

---

#### **7. Running Tests**

To run the test suite for the Rails API, use the following command:
```bash
docker-compose exec shipsticks-coding-challenge_rails-api bundle exec rails test
```

## **Notes on Design Decisions and Considerations**

This section outlines key design choices made during the development of the application, highlighting the rationale behind them and the considerations they address.

---

#### **1. GraphQL Error Handling**
**Design Decision**: Modified GraphQL to return non-200 HTTP status codes for errors.

- **Why**:
  - By default, GraphQL always returns a `200 OK` status, even when errors are present in the response. While this adheres to the GraphQL spec, it can make error handling more complex for clients, as they must inspect the `errors` field in the response body.
  - To simplify error handling, especially in cases where the client is expected to take different actions based on the type of error, this app customizes the server behavior to return appropriate HTTP status codes (e.g., `400 Bad Request`, `500 Internal Server Error`) for specific errors.

- **Implementation**:
  - Errors in resolvers are wrapped in `GraphQL::ExecutionError` with additional metadata.
  - A custom middleware inspects the response and adjusts the HTTP status based on error types.

- **Considerations**:
  - This approach improves compatibility with tools and libraries that rely on HTTP status codes for error handling.
  - Developers must ensure the client application still handles the `errors` field in the GraphQL response for granular error details.

---

#### **2. State and Query Management with React Query (Tanstack Query)**
**Design Decision**: Used React Query (now Tanstack Query) to manage application state and API queries.

- **Why**:
  - React Query simplifies server-state management, providing features like caching, automatic retries, and background updates.
  - It eliminates the need for manually managing loading, error, and success states, reducing boilerplate code in components.

- **Implementation**:
  - Queries are defined using `useQuery` for fetching data and `useMutation` for performing GraphQL mutations.
  - Caching is leveraged to reduce redundant API calls, improving performance and user experience.

- **Considerations**:
  - React Query integrates seamlessly with GraphQL, but proper cache keys must be used to ensure consistent updates.
  - Background updates and automatic retries make the app more robust, but retry policies need to be carefully configured to avoid overloading the server.

---

#### **3. Modularity and Scalability**
**Design Decision**: The app is structured to support modularity and future scalability.

- **Why**:
  - A modular architecture ensures that new features can be added with minimal impact on existing code.
  - By separating concerns between backend (Rails API), frontend (React), and state management (React Query), the app remains maintainable as complexity grows.

- **Considerations**:
  - Each module is designed with clear responsibilities, reducing coupling and improving testability.
  - Dependency injection and hooks are used to manage shared logic and configurations efficiently.

---

#### **4. Developer Experience**
**Design Decision**: Prioritized tools and patterns that improve developer productivity.

- **Why**:
  - Efficient development tools and clear patterns help maintain consistency across the codebase and reduce onboarding time for new developers.

- **Examples**:
  - **GraphQL Codegen**: Used to generate TypeScript types for GraphQL operations, ensuring type safety.
  - **Docker**: Simplifies environment setup and ensures consistency between local and production environments.

- **Considerations**:
  - Emphasis was placed on choosing tools that integrate well with each other, minimizing conflicts and compatibility issues.
  - Documentation is provided to guide developers in understanding and using the design patterns effectively.

#### **5. Use of Semantic UI React**

**Design Decision**: Utilized Semantic UI React as the primary component library for building the frontend user interface.

- **Why**:
  - **Pre-Built Components**: Semantic UI React provides a rich set of ready-to-use components, such as buttons, forms, modals, and grids, enabling rapid development.
  - **Declarative API**: Its declarative API aligns well with React's component-based architecture, promoting clean and maintainable code.
  - **Customizability**: Components can be easily customized using props and theming, allowing for flexibility while maintaining a consistent design.

- **Implementation**:
  - **Component Usage**:
    - Modals were used for features like the dimensional calculator.
    - Grid layouts ensured responsive and consistent layouts across pages.
  - **Styling**:
    - Default Semantic UI styles were applied for rapid prototyping.
    - Custom theming was implemented where necessary to meet specific design requirements.

- **Considerations**:
  - **Accessibility**: While Semantic UI React provides accessible components, additional enhancements were made to ensure compliance with accessibility standards where necessary.
  - **Custom Theming**: Deeper customizations leveraged the Semantic UI theming system to align with project branding.
  - **Performance**: The built-in functionality of Semantic UI React components was carefully evaluated to avoid performance overhead.
  - **Consistency**: Using a centralized component library ensured visual and functional consistency across the application.

By leveraging Semantic UI React, the app achieves a polished and professional user interface while streamlining development through reusable, pre-styled components.

---

These design decisions were made with a focus on clarity, maintainability, and scalability while ensuring a smooth developer and user experience.