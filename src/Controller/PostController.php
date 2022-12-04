<?php

namespace App\Controller;
use App\Entity\Post;
use App\Entity\User;
use App\Form\PostType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PostController extends AbstractController
{
    private $em;
    /**
     *  @param $em
     */

    public function __construct(EntityManagerInterface $em) 
    {
        $this->em = $em;
    }

    #[Route('/' , name: 'app_post')]
    public function index(Request $request): Response 
    {
        $post = new Post();

        $posts = $this->em->getRepository(Post::class)->findAllPost();

        $form = $this->createForm(PostType::class, $post);
        $form->handleRequest($request);
        if($form->isSubmitted() && $form->isValid()){
            $url = str_replace(" ", "-", $form->get('title')->getData());
            $post -> setUrl($url); 
            $user = $this->em->getRepository(User::class)->find(1);
            $post->setUser($user);

            $this->em->persist($post);
            $this->em->flush();
            return $this->redirectToRoute('app_post');
        }


        return $this->render('post/index.html.twig', [
                'form' => $form->createView(),
                'posts' => $posts
        ]);
    }

/* CUD MANUAL
    #[Route('/post/{id}' , name: 'app_post')]
    public function index($id): Response
    {
        $post = $this->em->getRepository(Post::class)->find($id);
        $posts = $this->em->getRepository(Post::class)->findAll($id);
        $postsfindBy = $this->em->getRepository(Post::class)->findBy(['id' => 1, 'title' => 'Mi primer titulo']);
        $postsfindOneBy = $this->em->getRepository(Post::class)->findOneBy(['id' => 1]);

        $custom_post = $this->em->getRepository(Post::class)->findPost($id);
        return $this->render('post/index.html.twig', [
            'post' => $post,
            'posts' => $posts,
            'search' => $postsfindBy,
            'oneBy' => $postsfindOneBy,
            'custom_post' => $custom_post,
        ]);
     }
     
     #[Route('/insert/post' , name: 'insert_post')]
     public function insert() {
        $post = new Post('Otro post insertado', 'opinion', 'hola mundo', 'hola.jpg', 'other');
        $user = $this-> em->getRepository(User::class)->find(1);
        $post->setUser($user);
        $this->em->persist($post);
        $this->em->flush();
        return new JsonResponse(['suceces' => true]); 
     }

     #[Route('/update/post' , name: 'insert_post')]
     public function update() {
        $post = $this->em->getRepository(Post::class)->find(4);
        $post->setTitle('insertado desde update');
        $this->em->flush();
        return new JsonResponse(['suceces' => true]);
     }
     #[Route('/remove/post' , name: 'insert_post')]
     public function remove() {
        $post = $this->em->getRepository(Post::class)->find(4);
        $this->em->remove($post);
        $this->em->flush();
        return new JsonResponse(['suceces' => true]);
     } */
}
