const fs = require('fs');
const path = require('path');
const readline = require('readline');

const baseFolder = __dirname + '/';
const templates = [
  { file: '_screen.dart', subdir: '' },
  { file: 't_cubit.dart', subdir: 'cubit' },
  { file: 't_state.dart', subdir: 'cubit' },
];

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

function toClassName(snake) {
  return snake
    .split('_')
    .map((s) => s.charAt(0).toUpperCase() + s.slice(1))
    .join('');
}

function replaceClassNames(content, className) {
  return content
    .replace(/TPage/g, `${className}Page`)
    .replace(/_TScreenState/g, `_${className}ScreenState`)
    .replace(/TScreen/g, `${className}Screen`)
    .replace(/TCubit/g, `${className}Cubit`)
    .replace(/TState/g, `${className}State`);
}

function replaceImports(content, snakeName, subdir) {
  if (subdir === '') {
    content = content.replace(
      /import 'cubit\/t_cubit\.dart';/g,
      `import 'cubit/${snakeName}_cubit.dart';`
    );
    content = content.replace(
      /import 'cubit\/t_state\.dart';/g,
      `import 'cubit/${snakeName}_state.dart';`
    );
  }
  if (subdir === 'cubit') {
    content = content.replace(
      /import 't_state\.dart';/g,
      `import '${snakeName}_state.dart';`
    );
  }
  return content;
}

function replaceText(content, snakeName) {
  return content.replace(/Text\('TScreen'\)/g, `Text('${snakeName}')`);
}

rl.question('Enter screen name (snake_case, e.g. home, user_profile): ', (inputName) => {
  const snakeName = inputName.trim();
  if (!snakeName) {
    console.log('Error: name cannot be empty');
    rl.close();
    return;
  }

  const className = toClassName(snakeName);
  const screenFolder = path.join(path.dirname(baseFolder), snakeName);
  const cubitFolder = path.join(screenFolder, 'cubit');

  if (fs.existsSync(screenFolder)) {
    console.log(`Error: folder '${screenFolder}' already exists`);
    rl.close();
    return;
  }

  fs.mkdirSync(screenFolder, { recursive: true });
  fs.mkdirSync(cubitFolder, { recursive: true });

  const createdFiles = [];

  templates.forEach(({ file, subdir }) => {
    const templatePath = path.join(baseFolder, subdir, file);
    if (!fs.existsSync(templatePath)) {
      console.log(`Warning: template not found: ${templatePath}`);
      return;
    }

    let content = fs.readFileSync(templatePath, 'utf8');
    content = replaceClassNames(content, className);
    content = replaceImports(content, snakeName, subdir);
    content = replaceText(content, snakeName);

    let outFileName;
    if (file === '_screen.dart') {
      outFileName = `${snakeName}_screen.dart`;
    } else {
      outFileName = file.replace(/^t_/, `${snakeName}_`);
    }

    const outDir = subdir ? path.join(screenFolder, subdir) : screenFolder;
    const outPath = path.join(outDir, outFileName);

    fs.writeFileSync(outPath, content, 'utf8');
    createdFiles.push(path.relative(path.dirname(baseFolder), outPath));
  });

  console.log(`\n✅ Created ${createdFiles.length} files for '${className}' screen:\n`);
  createdFiles.forEach((f) => console.log(`  ${f}`));
  console.log(`\n📁 Location: ${screenFolder}`);
  console.log(`\n📝 Next steps:`);
  console.log(`  1. Add route in lib/router/app_route.dart:`);
  console.log(`     AutoRoute(page: ${className}Route.page),`);
  console.log(`  2. Run: dart run build_runner build --delete-conflicting-outputs`);

  rl.close();
});
