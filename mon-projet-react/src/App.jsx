import { useState } from 'react';
import Welcome from './Welcome';

function App() {
  const [compteur, setCompteur] = useState(0);

  const incrementer = () => {
    setCompteur(compteur + 1);
  };

  return (
    <div>
      <h1>Bienvenue sur mon site React ! 🚀</h1>
      <Welcome name="Morgane" />
      <div>
        <h2>Compteur: {compteur}</h2>
        <button onClick={incrementer}>Incrémenter</button>
      </div>
    </div>
  );
}

export default App;
