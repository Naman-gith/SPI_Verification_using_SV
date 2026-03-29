# SPI Verification Environment (SystemVerilog)

## Overview

This project implements a lightweight SystemVerilog-based verification environment for an SPI interface. It follows a modular architecture inspired by UVM concepts, including generator, driver, monitor, and scoreboard components communicating via mailboxes.

## Features

* Transaction-based stimulus generation
* Mailbox-driven communication between components
* Modular and scalable architecture
* Full-duplex SPI observation
* Self-checking using scoreboard
* Simple and extendable design

## Components

### Interface

Defines SPI signals and connects DUT with verification components.

* `spi_if`

  * Signals: `mosi`, `miso`, `sclk`, `cs`, `clk`, `rst`

### Transaction

Represents a single SPI transfer.

* `spi_transaction`

  * `data` : Transmit data
  * `rx_data` : Received data

### Generator

Creates randomized SPI transactions and sends them to the driver.

* Produces stimulus using randomization
* Sends transactions via `gen2drv` mailbox

### Driver

Drives SPI signals based on transactions.

* Receives transactions from generator
* Drives `mosi` and controls `cs`
* Synchronizes with `sclk`

### Monitor

Observes SPI activity and reconstructs transactions.

* Samples `miso` data
* Detects transaction boundaries using `cs`
* Sends captured data to scoreboard

### Scoreboard

Validates correctness of SPI communication.

* Compares transmitted vs received data
* Reports PASS/FAIL results

### Environment

Connects all components together.

* Instantiates generator, driver, monitor, scoreboard
* Manages mailboxes
* Runs all components in parallel

### Testbench

Top-level module to run simulation.

* Generates clock
* Applies reset
* Instantiates environment
* Controls simulation runtime

## Data Flow

Generator → Driver → DUT → Monitor → Scoreboard

## Simulation Flow

1. Reset is applied
2. Generator creates randomized transactions
3. Driver sends data over SPI
4. Monitor captures response from interface
5. Scoreboard checks correctness
6. Results are printed to console

## Assumptions

* Fixed data width of 8 bits
* Single SPI mode behavior
* Ideal timing (no delays or glitches modeled)
* Continuous clock availability

## Limitations

* No protocol assertions
* No functional coverage
* No SPI mode (CPOL/CPHA) handling
* No error injection
* Not based on full UVM library

## Possible Extensions

* Add SystemVerilog Assertions (SVA)
* Introduce functional coverage
* Support all SPI modes
* Convert to full UVM environment
* Add reference model for expected data
* Include error scenarios and robustness testing

## File Structure

* `spi_if.sv` : Interface definition
* `spi_transaction.sv` : Transaction class
* `spi_generator.sv` : Stimulus generator
* `spi_driver.sv` : Driver logic
* `spi_monitor.sv` : Monitor logic
* `spi_scoreboard.sv` : Checker
* `spi_env.sv` : Environment
* `tb.sv` : Top-level testbench

## Requirements

* SystemVerilog simulator (VCS, Questa, Xcelium, etc.)


Free to use for learning and educational purposes
