import * as THREE from 'three';
import { STLLoader } from 'three/addons/loaders/STLLoader.js';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';

const renderer = new THREE.WebGLRenderer({ antialias: true });
renderer.outputColorSpace = THREE.SRGBColorSpace;

renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setClearColor(0x000000);
renderer.setPixelRatio(window.devicePixelRatio);

renderer.shadowMap.enabled = true;
renderer.shadowMap.type = THREE.PCFSoftShadowMap;

document.body.appendChild(renderer.domElement);

const scene = new THREE.Scene();

const camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 1, 1000);
camera.position.set(4, 5, 11);

const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;
controls.enablePan = false;
controls.minDistance = 5;
controls.maxDistance = 100;
controls.minPolarAngle = 0.5;
controls.maxPolarAngle = 1.5;
controls.autoRotate = false;
controls.target = new THREE.Vector3(0, 1, 0);
controls.update();

const groundGeometry = new THREE.PlaneGeometry(20, 20, 32, 32);
groundGeometry.rotateX(-Math.PI / 2);
const groundMaterial = new THREE.MeshStandardMaterial({
  color: 0x555555,
  side: THREE.DoubleSide
});
const groundMesh = new THREE.Mesh(groundGeometry, groundMaterial);
groundMesh.castShadow = false;
groundMesh.receiveShadow = true;
scene.add(groundMesh);

const spotLight = new THREE.SpotLight(0xffffff, 3000, 100, 0.22, 1);
spotLight.position.set(0, 25, 0);
spotLight.castShadow = true;
spotLight.shadow.bias = -0.1;
scene.add(spotLight);

const stlLoader = new STLLoader();
stlLoader.load('/acceleratormodel/model/linac.stl', (geometry) => {
  console.log('loading STL model');
  geometry.computeVertexNormals();
  geometry.computeBoundingBox();
  const bbox = geometry.boundingBox;
  const size = new THREE.Vector3();
  bbox.getSize(size);
  const center = new THREE.Vector3();
  bbox.getCenter(center);
  // Center geometry at origin
  geometry.translate(-center.x, -center.y, -center.z);
  // Scale to fit in a 5 unit box
  const maxDim = Math.max(size.x, size.y, size.z);
  const scale = 5 / maxDim;
  geometry.scale(scale, scale, scale);
  // Create mesh
  const material = new THREE.MeshPhongMaterial({ color: 0x6699ff, shininess: 80, specular: 0x222222 });
  const mesh = new THREE.Mesh(geometry, material);
  mesh.castShadow = false;
  mesh.receiveShadow = false;
  // Rotate STL Z-up to Y-up
  mesh.rotation.x = -Math.PI / 2;
  // Move mesh so its base sits on the ground
  mesh.position.y = size.y * scale / 2 + 1.05;
  mesh.position.z -= 1;
  scene.add(mesh);
  const modelDiv = document.getElementById('3dmodel');
  if (modelDiv) modelDiv.style.display = 'none';
}, (xhr) => {
  if (xhr.lengthComputable) {
    console.log(`loading ${(xhr.loaded / xhr.total * 100).toFixed(2)}%`);
  }
}, (error) => {
  console.error(error);
});

window.addEventListener('resize', () => {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
});

function animate() {
  requestAnimationFrame(animate);
  controls.update();
  renderer.render(scene, camera);
}

animate();