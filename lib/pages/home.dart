import 'package:flutter/material.dart';

import 'inventory.dart';
import 'production.dart';
import 'reports.dart';
import 'verification.dart';

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  static const _modules = <_Module>[
    _Module(
      title: 'INVENTORY MANAGEMENT',
      subtitle: 'Receive raw materials, scan invoices & track stock',
      icon: Icons.view_in_ar_outlined,
      tint: Color(0xFFE5F7EC),
      page: InventoryPage(),
    ),
    _Module(
      title: 'PRODUCTION TRACKING',
      subtitle: 'Create batches, record ingredients, output & wastage',
      icon: Icons.factory_outlined,
      tint: Color(0xFFE7EEFB),
      page: ProductionPage(),
    ),
    _Module(
      title: 'VERIFICATION & BATCH TRACKING',
      subtitle: 'Review pending submission & trace batch history',
      icon: Icons.shield_outlined,
      tint: Color(0xFFFFF4D4),
      page: VerificationPage(),
    ),
    _Module(
      title: 'REPORT, COSTING & AI ASSISTANT',
      subtitle: 'View manufacturing cost, wastage and ask AI',
      icon: Icons.receipt_long_outlined,
      tint: Color(0xFFF3E8FF),
      page: ReportsPage(),
    ),
  ];

  void _openLoginPlaceholder(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const _LoginPlaceholderDialog(),
    );
  }

  void _onModuleTap(BuildContext context, _Module module) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => module.page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: ColoredBox(
            color: const Color(0xFFF6F7FB),
            child: Column(
              children: [
                const _EyeFlowHeader(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'HOME DASHBOARD',
                                  style: TextStyle(
                                    fontSize: 20,
                                    height: 1.1,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.2,
                                    color: Color(0xFF1A1D26),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Select any button',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9AA1AD),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _LoginAvatar(
                            onPressed: () => _openLoginPlaceholder(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      for (final module in _modules) ...[
                        _ModuleCard(
                          module: module,
                          onTap: () => _onModuleTap(context, module),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EyeFlowHeader extends StatelessWidget {
  const _EyeFlowHeader();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Center(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
                children: [
                  TextSpan(
                    text: 'EYE ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: 'FLOW',
                    style: TextStyle(color: Color(0xFFFF1A1A)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginAvatar extends StatelessWidget {
  const _LoginAvatar({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Login placeholder',
      child: Material(
        color: const Color(0xFFE6E8ED),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: const SizedBox(
            width: 42,
            height: 42,
            child: Center(
              child: Text(
                'S',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8B919C),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginPlaceholderDialog extends StatelessWidget {
  const _LoginPlaceholderDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sign in'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login is a placeholder. Nothing is saved or checked.',
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
          ),
          SizedBox(height: 16),
          TextField(
            enabled: false,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'name@company.com',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            enabled: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({required this.module, required this.onTap});

  final _Module module;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 16, 10, 16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: module.tint,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    module.icon,
                    color: const Color(0xFF1F2430),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module.title,
                        style: const TextStyle(
                          fontSize: 13.5,
                          height: 1.25,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.15,
                          color: Color(0xFF1A1D26),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        module.subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.3,
                          color: Color(0xFF8E95A3),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFFB0B6C0),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Module {
  const _Module({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.tint,
    required this.page,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color tint;
  final Widget page;
}
