# ASCON Encryption Algorithm Implementation

This project involves the design and implementation of the ASCON128 encryption algorithm, developed in SystemVerilog. ASCON128 is a lightweight cryptographic algorithm aimed at ensuring data confidentiality, integrity, and authenticity. Known for its efficiency, ASCON is particularly suited for constrained environments requiring secure data processing.

## Project Structure

The project is modular, featuring distinct components for each phase of the algorithm:

1. **Initialization**: Combines the encryption key, initialization vector (IV), and nonce to set up the initial state, establishing a secure base for subsequent operations.
2. **Associated Data Processing**: Processes associated data for message authenticity without direct encryption.
3. **Plaintext Encryption**: Divides plaintext into 64-bit blocks, applying transformations including permutation and XOR operations to generate the encrypted text.
4. **Finalization**: Produces the final cipher text and a 128-bit authentication tag, ensuring message security and integrity.

## Components

The ASCON algorithm is implemented as a series of interconnected modules:
- **Permutation**: A core component performing rounds of data transformations.
- **State Registers**: Manages intermediate data storage.
- **Counters**: Track rounds and encryption blocks.
- **State Machine**: Controls the flow and sequence of operations, adapting based on each stage of the algorithm.

The main directory, `PROJET_ASCON`, contains:
- `SRC/RTL`: Module descriptions in SystemVerilog.
- `SRC/BENCH`: Testbenches for validation.
- `LIB`: Compiled files for module and testbench organization.
- Scripts for automated compilation and simulation initialization.

## Challenges and Insights

This project highlighted the complexities of designing a synchronized cryptographic system and the importance of rigorous testing for modular components. Though certain bugs remain at the top level, simulations confirm the functionality of individual modules, offering a solid foundation for further optimization.
