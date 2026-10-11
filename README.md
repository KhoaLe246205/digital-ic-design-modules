# 💻 Digital IC Design Modules Portfolio

[![Language](https://img.shields.io/badge/Language-Verilog%20HDL-blue.svg)](https://en.wikipedia.org/wiki/Verilog)
[![Simulation](https://img.shields.io/badge/Simulation-ModelSim%20%7C%20QuestaSim-green.svg)](https://eda.sw.siemens.com)
[![Topic](https://img.shields.io/badge/Topic-RTL%20Design%20%7C%20FSM%20%7C%20Hardware%20IPs-purple.svg)](https://github.com/KhoaLe246205)

> **Tác giả (Author)**: Lê Anh Khoa ([@KhoaLe246205](https://github.com/KhoaLe246205))  
> **Email liên hệ**: khoalekhoaanh2462005@gmail.com  
> **Giới thiệu**: Repository này tổng hợp các dự án thiết kế vi mạch số (**Digital IC / RTL Design**) độc lập, bao gồm đầy đủ tài liệu đặc tả kiến trúc (Draw.io, PDF, PPTX), mã nguồn Verilog RTL có khả năng tổng hợp (Synthesizable) và Testbench kiểm chứng chức năng.

---

## 📂 Danh Mục Các Dự Án Trong Repository (Projects Overview)

Mỗi thư mục dự án bên dưới đều có tệp **`README.md` chi tiết riêng** trình bày sâu về sơ đồ khối, bảng giao tiếp cổng (Port Interface), máy trạng thái (FSM), phân tích RTL và hướng dẫn mô phỏng:

| STT | Tên Dự Án (Project) | Thư Mục & Tài Liệu Chi Tiết | Tóm Tắt Kỹ Thuật (Technical Highlights) |
| :-: | :--- | :--- | :--- |
| **01** | **Parametric LIFO Buffer**<br/>*(Hardware Stack IP)* | 📁 [`01_LIFO_Buffer/`](01_LIFO_Buffer/)<br/>📖 [Xem README chi tiết](01_LIFO_Buffer/README.md) | Bộ đệm phần cứng ngăn xếp (Last-In, First-Out) tham số hóa độ rộng & độ sâu; tối ưu hóa phần cứng bằng **1 bộ cộng bù 2 dùng chung** cho cả Push/Pop; tích hợp cờ ngưỡng động (`low_th`, `high_th`) và bảo vệ chống tràn/cạn (`lifo_ov`, `lifo_ud`). |
| **02** | **NVM Serial Reader**<br/>*(Memory Controller)* | 📁 [`02_NVM_Reader/`](02_NVM_Reader/)<br/>📖 [Xem README chi tiết](02_NVM_Reader/README.md) | Bộ điều khiển đọc bộ nhớ bất biến (Non-Volatile Memory / Flash / EEPROM), tự động cấp địa chỉ truy xuất, chốt dữ liệu song song 8-bit và chuyển đổi sang luồng bit nối tiếp qua thanh ghi dịch PISO và FSM 3 trạng thái. |
| **03** | **Traffic Light Controller**<br/>*(FSM & BCD Display)* | 📁 [`03_Traffic_Light_Controller/`](03_Traffic_Light_Controller/)<br/>📖 [Xem README chi tiết](03_Traffic_Light_Controller/README.md) | Hệ thống điều khiển đèn giao thông tự động theo thời gian thực (**Xanh 18s $\rightarrow$ Vàng 3s $\rightarrow$ Đỏ 15s**); đồng bộ chuyển pha không trễ (Look-ahead Pre-last); tích hợp bộ tách số thập phân **Binary-to-BCD** bằng phép trừ lặp và giải mã ra 2 đèn LED 7 đoạn. |
| **04** | **PISO & SIPO Transceiver**<br/>*(Bidirectional Shift Reg)* | 📁 [`04_PISO_SIPO_Shift_Registers/`](04_PISO_SIPO_Shift_Registers/)<br/>📖 [Xem README chi tiết](04_PISO_SIPO_Shift_Registers/README.md) | Bộ chuyển đổi dữ liệu hai chiều 8-bit hợp nhất cả 2 chế độ **Song song $\rightarrow$ Nối tiếp (PISO)** và **Nối tiếp $\rightarrow$ Song song (SIPO)** trên một thanh ghi dịch duy nhất, điều phối bởi Moore FSM 4 trạng thái và bộ đếm chu kỳ bit. |

---

## 🗂️ Cấu Trúc Tổng Thể Repository (Repository Structure)

```text
02_Digital_IC_Design_Modules/
├── 01_LIFO_Buffer/                  # Dự án 1: Bộ đệm ngăn xếp phần cứng LIFO tham số hóa
│   ├── docs/                        # Bản vẽ kiến trúc Draw.io, báo cáo PDF (VN/EN), slide PPTX
│   ├── rtl/                         # Mã nguồn Verilog (top, pointer, status, ov-uv, memory)
│   ├── tb/                          # Self-checking Testbench
│   └── README.md                    # Tài liệu kỹ thuật chi tiết của LIFO Buffer
│
├── 02_NVM_Reader/                   # Dự án 2: Bộ điều khiển đọc bộ nhớ bất biến NVM
│   ├── docs/                        # Bản vẽ thiết kế từng module Draw.io và slide PPTX
│   ├── rtl/                         # Mã nguồn Verilog (top, controller, FSM, counter, PISO)
│   ├── tb/                          # Testbench mô phỏng đọc liên tiếp nhiều địa chỉ
│   └── README.md                    # Tài liệu kỹ thuật chi tiết của NVM Reader
│
├── 03_Traffic_Light_Controller/     # Dự án 3: Bộ điều khiển đèn giao thông & giải mã LED 7 đoạn
│   ├── docs/                        # Sơ đồ khối Draw.io, bảng phân tích Waveform.xlsx, PPTX
│   ├── rtl/                         # Mã nguồn Verilog (top, FSM, counters, decimal_split, hex2seg)
│   ├── tb/                          # Testbench kiểm chứng chu trình đèn và hiển thị
│   └── README.md                    # Tài liệu kỹ thuật chi tiết của Traffic Light Controller
│
├── 04_PISO_SIPO_Shift_Registers/    # Dự án 4: Bộ chuyển đổi hai chiều PISO / SIPO 8-bit
│   ├── docs/                        # Bản vẽ đặc tả thiết kế Design_Spec.drawio
│   ├── rtl/                         # Mã nguồn Verilog (top, controller, FSM, counter, PISO_SIPO_8bit)
│   ├── tb/                          # Testbench kiểm chứng chuyển đổi 2 chiều PISO & SIPO
│   └── README.md                    # Tài liệu kỹ thuật chi tiết của PISO/SIPO Shift Registers
│
├── .gitignore                       # Cấu hình loại bỏ file tạm của trình mô phỏng EDA
└── README.md                        # Trang tổng quan giới thiệu các dự án trong Repository
```

---

## 🛠️ Công Cụ Sử Dụng (Tools & Environment)
* **Ngôn ngữ thiết kế**: Verilog HDL (IEEE 1364-2001/2005, Synthesizable RTL).
* **Trình mô phỏng kiểm chứng**: Mentor Graphics ModelSim / Siemens QuestaSim.
* **Công cụ vẽ sơ đồ kiến trúc**: Draw.io (Diagrams.net).
