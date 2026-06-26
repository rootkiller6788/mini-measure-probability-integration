# Mini Measure, Probability & Integration（迷你测度、概率与积分）

一套**从零开始的 Lean 4 实现**，涵盖大学层次的测度论、概率论与积分理论。每个子包对应 MIT 及其他顶尖大学课程，使用 Lean 4 证明助手和内核库从第一性原理构建测度与概率论的基础。

## 子包

| 子包 | 主题 | 核心课程 |
|------|------|----------|
| [mini-measure-theory](mini-measure-theory/) | 测度、σ-代数、Caratheodory 扩张、Borel 测度 | MIT 18.102, Stanford Math 172 |
| [mini-measurable-functions](mini-measurable-functions/) | 可测函数、简单函数、逼近定理 | MIT 18.102, Harvard Math 212 |
| [mini-lebesgue-integration](mini-lebesgue-integration/) | 勒贝格积分、控制收敛定理、Fubini、L^p 空间 | MIT 18.102, Princeton MAT 570 |
| [mini-product-fubini](mini-product-fubini/) | 乘积测度、Fubini-Tonelli、卷积、累次积分 | MIT 18.102, Berkeley Math 202B |
| [mini-probability-theory](mini-probability-theory/) | 概率空间、随机变量、期望、分布、矩 | MIT 18.05, Stanford Math 151 |
| [mini-independence-convergence](mini-independence-convergence/) | 独立性、大数定律、中心极限定理、收敛模式 | MIT 18.05, Harvard Stat 110 |
| [mini-conditional-martingale](mini-conditional-martingale/) | 条件期望、鞅、停时、可选停时定理 | MIT 18.177, Cambridge Part III |
| [mini-stochastic-processes](mini-stochastic-processes/) | 布朗运动、马尔可夫链、泊松过程、伊藤积分 | MIT 18.177, Stanford Math 228 |

## 设计理念

- **零外部依赖** -- 纯 Lean 4，仅导入内核模块及同级子包
- **自包含子包** -- 每个子包拥有独立的 `lakefile.lean`、Core/、Morphisms/、Constructions/、Theorems/
- **理论到代码的映射** -- 每个模块包含内联 `#eval` 示例和定理陈述

## 构建

```bash
cd mini-measure-theory
lake build
lake env lean --run Test/Smoke.lean
```

需要 **Lean 4** 和 **Lake**。

## 项目结构

```
8. mini-measure-probability-integration/
├── mini-measure-theory/            # 测度、σ-代数、Caratheodory 扩张
├── mini-measurable-functions/      # 可测函数、逼近定理
├── mini-lebesgue-integration/      # 勒贝格积分、DCT、Fubini、L^p
├── mini-product-fubini/            # 乘积测度、Fubini-Tonelli、卷积
├── mini-probability-theory/        # 概率空间、随机变量、矩
├── mini-independence-convergence/  # 大数定律、中心极限定理、收敛模式
├── mini-conditional-martingale/    # 条件期望、鞅、停时
└── mini-stochastic-processes/      # 布朗运动、马尔可夫链、伊藤积分
```

## 许可证

MIT
