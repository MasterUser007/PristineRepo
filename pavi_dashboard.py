# pavi_dashboard.py
# Rich-based scientific dashboard for ExoSuite with dark theme

from rich.console import Console
from rich.panel import Panel
from rich.layout import Layout
from rich.table import Table
from rich.text import Text
from datetime import datetime
import os

console = Console()

def read_last_lines(file_path, max_lines=5):
    if not os.path.exists(file_path):
        return ['File not found.']
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        return lines[-max_lines:] if len(lines) > max_lines else lines

def get_disk_free_gb():
    try:
        import shutil
        total, used, free = shutil.disk_usage('.')
        return f'{free / (1024 ** 3):.2f} GB'
    except:
        return 'N/A'

def get_memory_used_mb():
    return 'N/A'  # Placeholder, platform-specific code needed

def render_test_qa_panel():
    log_lines = read_last_lines('pavi_chatbox.log', 10)
    text = ''.join(log_lines)
    return Panel(Text(text, style='white'), title='[cyan]Test & QA[/cyan]', border_style='cyan')

def render_automation_panel():
    log_lines = read_last_lines('pavi_chatbox.log', 10)
    filtered = [l for l in log_lines if any(x in l.lower() for x in ['remediation', 'fixed', 'auto'])]
    text = ''.join(filtered) if filtered else 'No recent automation logged.'
    return Panel(Text(text, style='white'), title='[cyan]Automation & Remediation[/cyan]', border_style='cyan')

def render_env_health_panel():
    disk_free = get_disk_free_gb()
    mem_used = get_memory_used_mb()
    table = Table.grid(padding=1)
    table.add_column(justify='right', style='white')
    table.add_column(style='green')
    table.add_row('Disk Free:', disk_free)
    table.add_row('Used Memory:', mem_used)
    return Panel(table, title='[cyan]Environment Health[/cyan]', border_style='cyan')

def render_dependency_panel():
    if os.path.exists('requirements.txt'):
        with open('requirements.txt', 'r', encoding='utf-8') as f:
            reqs = f.readlines()
        count = len(reqs)
        text = f'{count} entries'
    else:
        text = 'requirements.txt missing!'
    return Panel(Text(text, style='white'), title='[cyan]Dependency & Config Health[/cyan]', border_style='cyan')

def render_learning_panel():
    lines = read_last_lines('pavi_learning_log.md', 5)
    text = ''.join(lines) if lines else 'No recent learning log entries.'
    return Panel(Text(text, style='white'), title='[cyan]Learning & Actions[/cyan]', border_style='cyan')

def render_active_tasks_panel():
    lines = read_last_lines('pavi_chatbox.log', 10)
    active_lines = [l for l in lines if any(x in l.lower() for x in ['started', 'initiated', 'in progress'])]
    text = ''.join(active_lines) if active_lines else 'All jobs complete. Standing by.'
    return Panel(Text(text, style='white'), title='[cyan]Active Tasks[/cyan]', border_style='cyan')

def main():
    layout = Layout()
    layout.split_column(
        Layout(name='header', size=3),
        Layout(name='body', ratio=1),
        Layout(name='footer', size=1)
    )
    layout['body'].split_row(
        Layout(name='left'),
        Layout(name='middle'),
        Layout(name='right'),
    )

    layout['header'].update(Panel(Text('EXOSUITE: PAVI PROJECT STATUS DASHBOARD', style='bold cyan', justify='center'), style='on rgb(24,28,35)'))

    # Left column panels
    layout['left'].split_column(
        Layout(render_test_qa_panel(), name='testqa'),
        Layout(render_automation_panel(), name='automation'),
    )

    # Middle column panels
    layout['middle'].split_column(
        Layout(render_env_health_panel(), name='envhealth'),
        Layout(render_dependency_panel(), name='dependency'),
    )

    # Right column panels
    layout['right'].split_column(
        Layout(render_learning_panel(), name='learning'),
        Layout(render_active_tasks_panel(), name='activetasks'),
    )

    footer_text = f'Last updated: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}'
    layout['footer'].update(Panel(Text(footer_text, style='dim white', justify='right'), style='on rgb(24,28,35)'))

    console.clear()
    console.print(layout)

if __name__ == '__main__':
    main()
